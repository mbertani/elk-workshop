
# Setup

In the following, we make sure logstash works correctly in your system.

1. Run:
 - Windows ``` verify-logstash.ps1``` 
 - Linux ``` verify-logstash.sh``` 

2. Write something in you console and finish with CR. 
>In powershell disregard warning about "Received an event that has a different character encoding than you configured.... :expected_charset=>"UTF-8"..."

3. Exit with Ctrl+c


# What does the script do?

1. Runs logstash and verifies the input file

```>..\..\..\logstash-2.1.1\bin\logstash agent -f verify.conf --configtest```

```$ ../../../logstash-2.1.1/bin/logstash agent -f verify.conf --configtest```

2. Runs the command again without the test check 

```> ..\..\..\logstash-2.1.1\bin\logstash agent -f verify.conf```

```$ ../../../logstash-2.1.1/bin/logstash agent -f verify.conf```


## Further info

[configuration-file-structure](https://www.elastic.co/guide/en/logstash/current/configuration-file-structure.html)
