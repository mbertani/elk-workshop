function download($url,$file) {
	if (-not (test-path $file)) {
		Write-Host "Downloading $url" -ForegroundColor Green
		$client = new-object System.Net.WebClient
		$client.DownloadFile($url,$file)
	} else {
		Write-Host "$url already downloaded to $file"
	}
}

#source: http://www.howtogeek.com/tips/how-to-extract-zip-files-using-powershell/
function Expand-ZIPFile($file, $destination)
{
$fileObj = gci $file
$unzipedDest = $fileObj.FullName.Replace($fileObj.Extension,"")
if (test-path $unzipedDest) { 
	Write-Host "$unzipedDest already exists. Exiting..." 
	return 
	}
$shell = new-object -com shell.application
$zip = $shell.NameSpace($file)
Write-Host "Unzipper $file" -ForegroundColor Green
foreach($item in $zip.items())
	{
		$shell.Namespace($destination).copyhere($item)
	}
}


$esVersion = "elasticsearch-2.4.0"
$elasticsearchURL = "https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/2.4.0/elasticsearch-2.4.0.zip"
$elasticsearchFile = "$PSScriptRoot\$esVersion.zip"
download -url $elasticsearchURL -file $elasticsearchFile

$lsVersion = "logstash-2.4.0"
$logstashURL = "https://download.elastic.co/logstash/logstash/logstash-2.4.0.zip"
$logstashFile = "$PSScriptRoot\$lsVersion.zip"
download -url $logstashURL -file $logstashFile

$kVersion = "kibana-4.6.0-windows-x86"
$kibanaURL ="https://download.elastic.co/kibana/kibana/kibana-4.6.0-windows-x86.zip"
$kibanaFile = "$PSScriptRoot\$kVersion.zip"
download -url $kibanaURL -file $kibanaFile

$fbVersion = "filebeat-1.1.1-windows"
$fileBeatURL ="https://download.elastic.co/beats/filebeat/filebeat-1.1.1-windows.zip"
$fileBeatFile = "$PSScriptRoot\$fbVersion.zip"
download -url $fileBeatURL -file $fileBeatFile

Expand-ZIPFile –File $elasticsearchFile –Destination "$PSScriptRoot"
Expand-ZIPFile –File $logstashFile –Destination "$PSScriptRoot"
Expand-ZIPFile –File $kibanaFile –Destination "$PSScriptRoot"
# Expand-ZIPFile –File $fileBeatFile –Destination "$PSScriptRoot"


push-Location
cd "$esVersion\bin"
.\plugin install lmenezes/elasticsearch-kopf/master
pop-Location

push-Location
cd "$lsVersion\bin"
.\plugin install logstash-input-jdbc
.\plugin install logstash-input-beats
pop-Location

push-Location
cd "$kVersion\bin"
.\kibana plugin -i kibana/timelion
.\kibana plugin -i elastic/sense
# https://github.com/sirensolutions/kibi_radar_vis
.\kibana plugin -i kibi_radar_vis -u  https://github.com/sirensolutions/kibi_radar_vis/archive/0.1.0.zip
# https://github.com/sirensolutions/kibi_wordcloud_vis
.\kibana plugin -i kibi_wordcloud_vis -u https://github.com/sirensolutions/kibi_wordcloud_vis/raw/0.1.0/target/kibi_wordcloud_vis-0.1.0.zip
# https://github.com/sirensolutions/kibi_timeline_vis
.\kibana plugin -i kibi_timeline_vis -u https://github.com/sirensolutions/kibi_timeline_vis/raw/0.1.1/target/kibi_timeline_vis-0.1.1.zip
pop-Location