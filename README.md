# [Hands on workshop with ELK for Booster 2016](http://www.boosterconf.no/talks/595)

This repo contains all the resources needed for the workshop.

# Participant requirements
- Own laptop with 5GB free disk space. 
- Unix or Windows. 
- Make sure you also have at least 4 GB RAM available. 
- Java 8 installed 
- A good text editor (like Notepad++ or similar)

# Setup
- Clone this repository in your local system

```git clone --recursive https://github.com/mbertani/elk-workshop/ ```

- Initialize the submodules for reveal.js (to run the presentation locally)

``` git submodule update --init --recursive ```

- Check out the branch for the workshop

```git checkout booster2016 ```

- Run ```setup.ps1``` (windows powershell > 3.0) / ```setup.sh``` (linux) for atomatic setup. Otherwise follow the manual setup below.


## Links for manual setup

- Download Elasticsearch, Logstash and Kibana from the links below
- Unzip all 3 files inside your local repository. This step is important since we will assume relative paths to the binary files lying at the root of this repo.

### Elasticsearch 2.2.0

- Linux: [elasticsearch-2.2.0.tar.gz](https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.2.0/elasticsearch-2.2.0.tar.gz) 
- Windows: [elasticsearch-2.2.0.zip](https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/2.2.0/elasticsearch-2.2.0.zip) 

### Logstash 2.2.2

- Linux: [logstash-2.2.2.tar.gz](https://download.elastic.co/logstash/logstash/logstash-2.2.2.tar.gz)
- Windows: [logstash-2.2.2.zip](https://download.elastic.co/logstash/logstash/logstash-2.2.2.zip)

### Kibana 4.4.1

- [kibana-4.4.1-windows](https://download.elastic.co/kibana/kibana/kibana-4.4.1-windows.zip)
- [kibana-4.4.1-linux-x64.tar.gz](https://download.elastic.co/kibana/kibana/kibana-4.4.1-linux-x64.tar.gz)
- [kibana-4.4.1-linux-x86.tar.gz](https://download.elastic.co/kibana/kibana/kibana-4.4.1-linux-x86.tar.gz)


# Logstash pipelines

## LAPD 

In this pipeline we analize the criminal records for LAPD. To get started, navigate to logtash/pipelines/lapd and follow the instructions at the Readme.md file.

## HTTPD

Because of time restrictions, we will not cover this pipeline during the workshop, but we leave it as homework for the audience.

In this pipeline we analyze HTTP access logs, conforming to the Apache Combined Log Format. This format is commonly used by most HTTP servers. To get started, navigate to logstash/pipelines/httpd and follow the instructions in the Readme.md file.
