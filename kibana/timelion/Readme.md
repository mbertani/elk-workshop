# Function for Timelion for outlier detection
[source](https://www.elastic.co/blog/implementing-a-statistical-anomaly-detector-part-2)

## Install Showif-series functions

- Shut down Kibana
- Add the [Showifgreater.js](https://github.com/mbertani/elk-workshop/blob/booster2016/kibana/timelion/showifgreater.js) to your Timelion source (kibana/installedPlugins/timelion/series_functions/showifgreater.js) 
- Add the [Showifsmaller.js](https://github.com/mbertani/elk-workshop/blob/booster2016/kibana/timelion/showifsmaller.js) to your Timelion source (kibana/installedPlugins/timelion/series_functions/showifsmaller.js) 
- Delete the optimized bundle (rm kibana/optimize/bundles/*) 
- Restart Kibana 

## Query constructor for timelion

- Run timelion_analysis.ps1
- Copy and paste queries from output file query.txt into timelion

