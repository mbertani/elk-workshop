# Function for Timelion for outlier detection
[source](https://www.elastic.co/blog/implementing-a-statistical-anomaly-detector-part-2)

## Install Showifgreater

- Shut down Kibana
- Add the [Showifgreater.js](https://gist.github.com/polyfractal/5c584f515c4dbd2d5a8f) to your Timelion source (kibana/installedPlugins/timelion/series_functions/showifgreater.js) 
  You only need showifgreater.
- Delete the optimized bundle (rm kibana/optimize/bundles/timelion.bundle.js) 
- Restart Kibana 

## Query constructor for timelion

- Run timelion_analysis.ps1
- Copy and paste queries from output file query.txt into timelion

