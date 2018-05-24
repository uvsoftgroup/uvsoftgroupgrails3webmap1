<!DOCTYPE HTML>
<html lang="en">
  <head>
    <title>Web Map Application</title>
   
   <script src="http://maps.google.com/maps/api/js?v=3&amp;sensor=false"></script>
	<link rel="stylesheet" href="../theme/default/style.css" type="text/css">
     <link rel="stylesheet" href="style.css" type="text/css">
   <script src="http://openlayers.org/api/OpenLayers.js"></script>
 
   
  <link rel="stylesheet" href="${resource(dir: 'css', file:'style.css')}" type="text/css">
 <link rel="stylesheet" href="${resource(dir: 'css', file:'mapclient.css')}" type="text/css">
 <link rel="stylesheet" href="${resource(dir: 'css', file:'style_test.css')}" type="text/css">
 <link rel="stylesheet" href="${resource(dir: 'css', file:'style_Sicherung.css')}" type="text/css">
 
 <script type="text/javascript">
 var lon = 89.76;
 var lat = 24.45;
 var zoom =6;
 var map;
 function init(){

	 var pointFeatures=[];
	 
	 var options = {
			    projection: new OpenLayers.Projection("EPSG:900913"),
			    units: "m",
			    maxResolution: 156543.0339,
			    maxExtent: new OpenLayers.Bounds(-20037508.34, -20037508.34,
			                                     20037508.34, 20037508.34)
			    };
	            map = new OpenLayers.Map("map", options);
					
			    var fromProjection = new OpenLayers.Projection("EPSG:4326");   // Transform from WGS 1984
			    var toProjection   = new OpenLayers.Projection("EPSG:900913"); // to Spherical Mercator Projection
			    var position       = new OpenLayers.LonLat(89.400558, 24.794455).transform( fromProjection, toProjection);	
			    var zoom           = 7;   

			    // open street map
				var osm= new OpenLayers.Layer.OSM();
				 //to get google hybrid map
			    var google_hybrid=new OpenLayers.Layer.Google("Google Hybrid",
			     { type: google.maps.MapTypeId.HYBRID}
			     );
				 // to get google Streets map
				var gmap = new OpenLayers.Layer.Google("Google Streets");
				// to get google Satellite map 
			    var google_satellite=new OpenLayers.Layer.Google("Google Satellite",
			     { type: google.maps.MapTypeId.SATELLITE}
			     ); 
				
			   // to get google terrain map
			    var google_terrian=new OpenLayers.Layer.Google("Google Terrain",
			     { type: google.maps.MapTypeId.TERRAIN}
			     );
			     var vector_layer=new OpenLayers.Layer.Vector('Basic Vector Layer');
			     var station=new OpenLayers.Layer.Vector('Station Location');
			     map.addLayers([osm,google_hybrid, gmap, google_satellite, google_terrian, vector_layer, station]);
			     
			     var point=new OpenLayers.Geometry.Point(89.00, 24.45);
			     var feature_point=new OpenLayers.Feature.Vector(point);
			     station.addFeatures([feature_point]);

			     var controls_arrays=[
			                          new OpenLayers.Control.Navigation(),
			                          new OpenLayers.Control.PanZoomBar(),
			                          new OpenLayers.Control.LayerSwitcher(),
			                          new OpenLayers.Control.Permalink(),
			                          new OpenLayers.Control.MousePosition(),
			                          new OpenLayers.Control.ScaleLine(),
			                          new OpenLayers.Control.KeyboardDefaults(),
			                          new OpenLayers.Control.Graticule(),
			                          new OpenLayers.Control.Scale(),
			                          new OpenLayers.Control.EditingToolbar(vector_layer),
			                          new OpenLayers.Control.OverviewMap({maximized: true})
			                          
			                          ];
				 
				 map.addControl(new OpenLayers.Control.LayerSwitcher());
				 map.addControl(new OpenLayers.Control.MousePosition());
				 map.addControl(new OpenLayers.Control.Navigation());
			     map.addControl(new OpenLayers.Control.PanZoomBar());
			     map.addControl(new OpenLayers.Control.MousePosition({}));
			     map.addControl(new OpenLayers.Control.ScaleLine({}));
			     map.addControl(new OpenLayers.Control.EditingToolbar(vector_layer));
			     map.addControl(new OpenLayers.Control.Graticule());
			     map.addControl(new OpenLayers.Control.KeyboardDefaults({}));
			     map.addControl(new OpenLayers.Control.OverviewMap({maximized: true}));
				 map.addControl(new OpenLayers.Control.SelectFeature({}));
				
				map.setCenter(position, zoom );
                map.layers[1].features
 
 
 }
 </script>
  </head>

 <body onload="init()"> 
 
 <table>
 <tr>
 <td width="20%">
<div style='width: 10px; height:10px;'></div>
</td>
<td width="90%">
<div id="map"  style='width: 900px; height:550px;'></div>
</td>
</tr>
</table>
 
 </body>
</html>