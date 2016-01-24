#!/usr/bin/ruby

class IPGenerator
  public
  def initialize(session_count, session_length)
    @session_count = session_count
    @session_length = session_length

    @sessions = {}
  end

  public
  def get_ip
    session_gc
    session_create

    ip = @sessions.keys[Kernel.rand(@sessions.length)]
    @sessions[ip] += 1
    return ip
  end

  private
  def session_create
    while @sessions.length < @session_count
      @sessions[random_ip] = 0
    end
  end

  private
  def session_gc
    @sessions.each do |ip, count|
      @sessions.delete(ip) if count >= @session_length
    end
  end

  private
  def random_ip
    octets = []
    octets << Kernel.rand(223) + 1
    3.times { octets << Kernel.rand(255) }

    return octets.join(".")
  end
end

class LogGenerator
  EXTENSIONS = {
    'html' => 40,
    'php' => 30,
    'png' => 15,
    'gif' => 10,
    'css' => 5,
  }

  RESPONSE_CODES = {
    200 => 92,
    404 => 5,
    503 => 3,
  }

  USER_AGENTS = {
    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)" => 30,
    "Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.50 Safari/534.24" => 30,
    "Mozilla/5.0 (X11; Linux x86_64; rv:6.0a1) Gecko/20110421 Firefox/6.0a1" => 40,
  }

  public
  def initialize(ipgen)
    @ipgen = ipgen
  end

  public
  def write_qps(dest, qps)
    sleep = 1.0 / qps
    t = 0
    720000.times do
      write(dest, t)
      t = t + sleep
    end
  end

  public
  def write(dest, secs)
      ip = @ipgen.get_ip
      ext = pick_weighted_key(EXTENSIONS)
      resp_code = pick_weighted_key(RESPONSE_CODES)
      resp_size = Kernel.rand(2 * 1024) + 192;
      ua = pick_weighted_key(USER_AGENTS)
      date = (Time.new(2015, 1, 25) + secs).strftime("%d/%b/%Y:%H:%M:%S %z")
      dest.write("#{ip} - - [#{date}] \"GET /test.#{ext} HTTP/1.1\" " +
                 "#{resp_code} #{resp_size} \"-\" \"#{ua}\"\n")
  end

  private
  def pick_weighted_key(hash)
    total = 0
    hash.values.each { |t| total += t }
    random = Kernel.rand(total)

    running = 0
    hash.each do |key, weight|
      if random >= running and random < (running + weight)
        return key
      end
      running += weight
    end

    return hash.keys.first
  end
end

$stdout.sync = true
ipgen = IPGenerator.new(100, 10)
LogGenerator.new(ipgen).write_qps($stdout, 10)
