<!DOCTYPE HTML>
<html lang="en">
  <head>
 <title>Measurement Tool</title>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ol3/3.6.0/ol.css" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/ol3/3.6.0/ol.js"></script>

   <g:javascript src="measurement.js"/> 
   
  <link rel="stylesheet" href="${resource(dir: 'css', file:'measurement.css')}" type="text/css">

   
 </head>

 <body onload="measurement();">
 
<div class="row-fluid">
  <div class="span12">
    <div id="map" class="map"></div>
  </div>
</div>

<form class="form-inline">
  <label>Geometry type &nbsp;</label>
    <select id="type">
      <option value="length">Length</option>
      <option value="area">Area</option>
    </select>
    <label class="checkbox"><input type="checkbox" id="geodesic"/>use geodesic measures</label>
</form>

 </body>
</html>