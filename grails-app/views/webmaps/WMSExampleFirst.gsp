<!DOCTYPE html>
<html>
<head>
<title>WMS custom tile grid 512x256 example</title>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ol3/3.5.0/ol.css" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/ol3/3.5.0/ol.js"></script>

</head>
<body>
<div class="container-fluid">

<div class="row-fluid">
  <div class="span12">
    <div id="map" class="map"></div>
  </div>
</div>

</div>
<script>
var projExtent = ol.proj.get('EPSG:3857').getExtent();
var startResolution = ol.extent.getWidth(projExtent) / 256;
var resolutions = new Array(22);
for (var i = 0, ii = resolutions.length; i < ii; ++i) {
  resolutions[i] = startResolution / Math.pow(2, i);
}
var tileGrid = new ol.tilegrid.TileGrid({
  origin: ol.extent.getBottomLeft(projExtent),
  resolutions: resolutions,
  tileSize: [512, 256]
});

var layers = [
  new ol.layer.Tile({
    source: new ol.source.MapQuest({layer: 'sat'})
  }),
  new ol.layer.Tile({
    extent: [-13884991, 2870341, -7455066, 6338219],
    source: new ol.source.TileWMS({
      url: 'http://localhost:1000/geoserver/topp/wms?service=WMS&version=1.1.0&request=GetMap&layers=topp:tasmania_roads&styles=&bbox=145.19754,-43.423512,148.27298000000002,-40.852802&width=512&height=427&srs=EPSG:4326&format=application/openlayers',
      params: {'LAYERS': 'topp:tasmania_roads', 'TILED': true},
      serverType: 'geoserver',
      tileGrid: tileGrid

      
    })
  })
];
var map = new ol.Map({
  layers: layers,
  target: 'map',
  view: new ol.View({
    center: [-10997148, 4569099],
    zoom: 4
  })
});

</script>
</body>
</html>