<!DOCTYPE html>
<html>
<head>
<title>MapQuest example</title>
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
    <select id="layer-select">
      <option value="Aerial">Aerial</option>
      <option value="AerialWithLabels">Aerial with labels</option>
      <option value="Road" selected>Road</option>
    </select>
  </div>
</div>

</div>
<script>
var layers = [
  new ol.layer.Tile({
    style: 'Road',
    source: new ol.source.MapQuest({layer: 'osm'})
  }),
  new ol.layer.Tile({
    style: 'Aerial',
    visible: false,
    source: new ol.source.MapQuest({layer: 'sat'})
  }),
  new ol.layer.Group({
    style: 'AerialWithLabels',
    visible: false,
    layers: [
      new ol.layer.Tile({
        source: new ol.source.MapQuest({layer: 'sat'})
      }),
      new ol.layer.Tile({
        source: new ol.source.MapQuest({layer: 'hyb'})
      })
    ]
  })
];

var map = new ol.Map({
  layers: layers,
  target: 'map',
  view: new ol.View({
    center: ol.proj.transform(
        [90.382653, 23.739747], 'EPSG:4326', 'EPSG:3857'),
    zoom: 9
  })
});

$('#layer-select').change(function() {
  var style = $(this).find(':selected').val();
  var i, ii;
  for (i = 0, ii = layers.length; i < ii; ++i) {
    layers[i].set('visible', (layers[i].get('style') == style));
  }
});
$('#layer-select').trigger('change');

</script>
</body>
</html>