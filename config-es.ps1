$esConfig = gc "$pwd\elasticsearch-2.2.0\config\elasticsearch.yml"

function has-setting-commented($path,$setting) {
$localFile = gc $path
	foreach ($line in $localFile) {
		if ( $line.Contains($setting) -and $line.Contains("#")) { 
			return $true
			}
	}
	
	return $false
}

function remove-comment($path,$setting) {
	foreach ($line in $esConfig) {
		if ( $line.Contains($setting) -and ($line.Contains("#"))) { 
			return 
			}
	}
}

if has-setting-commented($esConfig,"cluster.name") {
	
}

