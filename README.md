# elk-workshop
Hands on workshop with ELK

# Setup
- Clone this repository in your local system
- Download Elasticsearch, Logstash and Kibana 
- Unzip all 3 files inside your local repository

## Links

### Elasticsearch 2.1.1

https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.1.1/elasticsearch-2.1.1.tar.gz
https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/2.1.1/elasticsearch-2.1.1.zip

### Logstash 2.1.1

https://download.elastic.co/logstash/logstash/logstash-2.1.1.tar.gz
https://download.elastic.co/logstash/logstash/logstash-2.1.1.zip

### Kibana 4.3.1

https://download.elastic.co/kibana/kibana/kibana-4.3.1-windows.zip
https://download.elastic.co/kibana/kibana/kibana-4.3.1-linux-x64.tar.gz
https://download.elastic.co/kibana/kibana/kibana-4.3.1-linux-x86.tar.gz


# Logstash pipelines

## LAPD 

In this pipeline we analize the criminal records for LAPD. To get started, navigate to logtash/pipelines/lapd and follow the instructions at the Readme.md file.

## HTTPD

In this pipeline we analyze HTTP access logs, conforming to the Apache Combined Log Format. This format is commonly used by most HTTP servers. To get started, navigate to logstash/pipelines/httpd and follow the instructions in the Readme.md file.
