function removeWhiteSpace($string) {
	return $string -replace '(^\s+|\s+$)','' -replace '\s+',''
}

function writeToFile($comment,$query,$filename,$removeWhites) {

"`n$comment`n" | Out-File -FilePath $filename -Encoding utf8 -Append	
if ($removeWhites -eq $true) {
	$Local:output = removeWhiteSpace($query) 	
	} else {
	$Local:output = $query 		
	}			   
 $Local:output | Out-File -FilePath $filename -Encoding utf8 -Append				   
}

# Note that the units of the size of the window in movingaverage and movingstd are given by the time unit in timelion 
$filterQuery = "'THEFT'"
$movingaverage = "movingaverage(7,'left')" # center (balance past and future), left (past) or right (future). Defines how you place the time window to calculate the average
$movingstd = "movingstd(4)" 
$mainSeries = "es(q=$filterQuery)"
$ntimes = "multiply(3)"
$qBoundaries = ".$mainSeries.label($filterQuery),
				   .$mainSeries.$movingaverage.sum(.$mainSeries.$movingstd.$ntimes).label(#n-sigmaOver).color(red),
				   .$mainSeries.$movingaverage.subtract(.$mainSeries.$movingstd.$ntimes).label(#n-sigmaUnder).color(green)"

$qOutliers = ".$mainSeries.$movingaverage.color(gray).label(#movingaverage),
				  .$mainSeries.label($filterQuery),
				  .$mainSeries.showifgreater(.$mainSeries.$movingaverage.sum(.$mainSeries.$movingstd.$ntimes)).bars(3).label(#n-sigmaOver).color(red),
				  .$mainSeries.$movingaverage.subtract(.$mainSeries.$movingstd.$ntimes).showifgreater(.$mainSeries).bars(3).color(green).label(#n-sigmaUnder)"

writeToFile -comment "#Query to show boundaries" -query $qBoundaries -filename "$pwd\query.txt" -removeWhites $true
writeToFile -comment "#Query to show outliers" -query $qOutliers -filename "$pwd\query.txt" -removeWhites $true

$mainSeries =  "es(q=$filterQuery)"
$offset = "'-1w'" # m minute, d day, w week, M month y year
$offsetSeries = "es(q=$filterQuery,offset=$offset)"
$positiveOffsetColor = "color(red)"
$negativeOffsetColor = "color(green)"

$queryOffset = ".$mainSeries, .$mainSeries.multiply(.$mainSeries.subtract(.$offsetSeries).showifgreater(0).divide(.$mainSeries.subtract(.$offsetSeries).showifgreater(0))).$positiveOffsetColor.points().label('Increased wrt previous offset'), .$mainSeries.multiply(.$mainSeries.subtract(.$offsetSeries).multiply(-1).showifgreater(0).divide(.$mainSeries.subtract(.$offsetSeries).multiply(-1).showifgreater(0))).$negativeOffsetColor.points().label('Decreased wrt previous offset')"

writeToFile -comment "#Compare offset query" -query $queryOffset -filename "$pwd\query.txt" -removeWhites $false
