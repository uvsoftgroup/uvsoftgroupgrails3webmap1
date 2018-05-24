
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
        <title>OpenLayers All Overlays with Google and OSM</title>
        <link rel="stylesheet" href="../theme/default/style.css" type="text/css">
        <link rel="stylesheet" href="style.css" type="text/css">
        <script src="http://maps.google.com/maps/api/js?v=3&amp;sensor=false"></script>
        <script src="../OpenLayers.js"></script>
        <script src="js/all-overlays-google.js"></script>
    </head>
    
    <script>
    var map;

function init() {

    map = new OpenLayers.Map({
        div: "map",
        allOverlays: true
    });

    var osm = new OpenLayers.Layer.OSM();
    var gmap = new OpenLayers.Layer.Google("Google Streets", {visibility: false});

    // note that first layer must be visible
    map.addLayers([osm, gmap]);

    map.addControl(new OpenLayers.Control.LayerSwitcher());
    map.zoomToMaxExtent();

}
</script>
    <body onload="init()">
       
        <div id="map" class="smallmap"></div>
 
    </body>
</html>