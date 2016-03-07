function download () {
# call: download $url $filename
url=$1
filename=$2

if [ -e "$filename" ] 
then
    echo "$filename exists and will not be downloaded again"
else
    wget $url -O $filename
fi
}


function decompress() {
# decompress $filename $directory
file_name=$1
directory=$2
if [ -d "$directory" ] 
then
    echo "$directory exists and $file_name will not be decompressed again"
else
    tar -xf $file_name
fi

}

esVersion="elasticsearch-2.2.0"
elasticsearchURL="https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.2.0/elasticsearch-2.2.0.tar.gz"
esFilename=$esVersion.tar.gz

download $elasticsearchURL $esFilename
decompress $esFilename $esVersion

# ES Plugins
./$esVersion/bin/plugin install lmenezes/elasticsearch-kopf/master
# https://github.com/sirensolutions/siren-join
./$esVersion/bin/plugin install solutions.siren/siren-join/2.2.0

lsVersion="logstash-2.2.2"
logstashURL="https://download.elastic.co/logstash/logstash/logstash-2.2.2.tar.gz"
logstashFile=$lsVersion.tar.gz

download $logstashURL $logstashFile
decompress $logstashFile $lsVersion

# Logstash plugins
./$lsVersion/bin/plugin install logstash-input-jdbc
./$lsVersion/bin/plugin install logstash-input-beats


osversion () {
 uname -m | grep -q "x86_64"
}

if osversion 
then
   echo "64-bits OS detected"
   kVersion="kibana-4.4.1-linux-x64"
   kibanaURL="https://download.elastic.co/kibana/kibana/kibana-4.4.1-linux-x64.tar.gz"
else
   echo "32-bits OS detected"
   kVersion="kibana-4.4.1-linux-x86"
   kibanaURL="https://download.elastic.co/kibana/kibana/kibana-4.4.1-linux-x86.tar.gz"
fi

echo "Using URL for kibana $kibanaURL"
kibanaFile=$kVersion.tar.gz

download $kibanaURL $kibanaFile
decompress $kibanaFile $kVersion

# Kibana plugins
./$kVersion/bin/kibana plugin -i kibana/timelion
# https://github.com/sirensolutions/kibi_radar_vis
./$kVersion/bin/kibana plugin -i kibi_radar_vis -u  https://github.com/sirensolutions/kibi_radar_vis/archive/0.1.0.zip
# https://github.com/sirensolutions/kibi_wordcloud_vis
./$kVersion/bin/kibana plugin -i kibi_wordcloud_vis -u https://github.com/sirensolutions/kibi_wordcloud_vis/raw/0.1.0/target/kibi_wordcloud_vis-0.1.0.zip
# https://github.com/sirensolutions/kibi_timeline_vis
./$kVersion/bin/kibana plugin -i kibi_timeline_vis -u https://github.com/sirensolutions/kibi_timeline_vis/raw/0.1.1/target/kibi_timeline_vis-0.1.1.zip
