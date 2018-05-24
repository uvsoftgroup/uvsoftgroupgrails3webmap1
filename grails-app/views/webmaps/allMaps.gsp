<!DOCTYPE HTML>
<html lang="en">
  <head>
    <title>All Maps</title>
   <script src="http://maps.google.com/maps/api/js?v=3&amp;sensor=false"></script>
	<link rel="stylesheet" href="../theme/default/style.css" type="text/css">
     <link rel="stylesheet" href="style.css" type="text/css">
   <script src="http://openlayers.org/api/OpenLayers.js"></script>
   <g:javascript src="allMaps.js"/> 
   
  <link rel="stylesheet" href="${resource(dir: 'css', file:'style.css')}" type="text/css">
 <link rel="stylesheet" href="${resource(dir: 'css', file:'mapclient.css')}" type="text/css">
 <link rel="stylesheet" href="${resource(dir: 'css', file:'style_test.css')}" type="text/css">
 <link rel="stylesheet" href="${resource(dir: 'css', file:'style_Sicherung.css')}" type="text/css">
   
 </head>

 <body onload="allMaps();">
 
<table>
 <tr>
 <td width="20%">
<div style='width: 10px; height:10px;'></div>
</td>
<td width="90%">
<div id="maps"  style='width: 900px; height:550px;'></div>
</td>
</tr>
</table>
 </body>
</html>