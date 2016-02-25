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

$elasticsearchURL = "https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/zip/elasticsearch/2.2.0/elasticsearch-2.2.0.zip"
$elasticsearchFile = "$pwd\elasticsearch-2.2.0.zip"
download -url $elasticsearchURL -file $elasticsearchFile

$logstashURL = "https://download.elastic.co/logstash/logstash/logstash-2.2.2.zip"
$logstashFile = "$pwd\logstash-2.2.2.zip"
download -url $logstashURL -file $logstashFile

$kibanaURL ="https://download.elastic.co/kibana/kibana/kibana-4.4.1-windows.zip"
$kibanaFile = "$pwd\kibana-4.4.1-windows.zip"
download -url $kibanaURL -file $kibanaFile

Expand-ZIPFile –File $elasticsearchFile –Destination "$pwd"
Expand-ZIPFile –File $logstashFile –Destination "$pwd"
Expand-ZIPFile –File $kibanaFile –Destination "$pwd"

push-Location
cd "elasticsearch-2.2.0\bin"
.\plugin install lmenezes/elasticsearch-kopf/master
pop-Location

push-Location
cd "logstash-2.2.2\bin"
.\plugin install logstash-input-jdbc
.\plugin install logstash-input-beats
pop-Location

push-Location
cd "kibana-4.4.1-windows\bin"
.\kibana plugin -i kibana/timelion
pop-Location