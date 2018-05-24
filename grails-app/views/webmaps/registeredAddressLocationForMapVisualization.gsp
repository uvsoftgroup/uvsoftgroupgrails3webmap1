
<%@ page import="urbanmanagement.model.PlotInfo" %>

<!DOCTYPE HTML>
<html lang="en">
  <head>
    <title>General Information Map Portal Search</title>
   
  <script src="http://maps.google.com/maps/api/js?v=3&amp;sensor=false"></script>
   <script src="http://openlayers.org/api/OpenLayers.js"></script>
   
  <link rel="stylesheet" href="${resource(dir: 'css', file:'style.css')}" type="text/css">
 
  <g:javascript library="/GeoExt/script/GeoExt"/>
  <g:javascript library="/mymapjslib/dynamicStationLayer"/>
  <g:javascript library="/mymapjslib/dynamicStationLayerWithInformation"/>
 	
  <script type="text/javascript">

  var lon = 89.76;
  var lat = 24.45;
  var position;
  var positionMouse;
  var fromProjection;
  var toProjection;
  var zoom;
  var lonlat;
  var longitude;
  var latitude;
  var map;
  var pointFeatures=[];

  OpenLayers.Control.Click = OpenLayers.Class(OpenLayers.Control, {                
	     defaultHandlerOptions: {
	         'single': true,
	         'double': false,
	         'pixelTolerance': 0,
	         'stopSingle': false,
	         'stopDouble': false  
	     },

	     initialize: function(options) {
	         this.handlerOptions = OpenLayers.Util.extend(
	             {}, this.defaultHandlerOptions
	         );
	         OpenLayers.Control.prototype.initialize.apply(
	             this, arguments
	         ); 
	         this.handler = new OpenLayers.Handler.Click(
	             this, {
	                 'click': this.trigger
	             }, this.handlerOptions
	         );
	     }, 

	     trigger: function(e) {
	         lonlat = map.getLonLatFromPixel(e.xy);
	         var  lonlat1= new OpenLayers.LonLat(lonlat.lon,lonlat.lat).transform(toProjection,fromProjection);
	         alert("Clicked Geo-Coordinate (Longitude, Latitude) (" +parseFloat(+lonlat1.lon.toFixed(10))+ ","+parseFloat(+lonlat1.lat.toFixed(10))+")");
	 	  document.getElementById("longitude").innerHTML =parseFloat(+lonlat1.lon.toFixed(10));
	 	  document.getElementById("latitude").innerHTML =parseFloat(+lonlat1.lat.toFixed(10));
	    
	     }
	    
	 });

 function init(){

	
	 
	 var options = {
			    projection: new OpenLayers.Projection("EPSG:4326"),
			    units: "m",
			    maxResolution: 156543.0339,
			    maxExtent: new OpenLayers.Bounds(-20037508.34, -20037508.34, 20037508.34, 20037508.34)
	 			//displayProjection:new OpenLayers.Projection("EPSG:4326")
				};
	            map = new OpenLayers.Map("map", options);
					
			    fromProjection = new OpenLayers.Projection("EPSG:4326");   // Transform from WGS 1984
			    toProjection   = new OpenLayers.Projection("EPSG:900913"); // to Spherical Mercator Projection
			    position       = new OpenLayers.LonLat(90.151363, 24.005651).transform( fromProjection, toProjection);	
			    zoom           =7;   
			
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


			   

var renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
renderer = (renderer) ? [renderer] : OpenLayers.Layer.Vector.prototype.renderers;


var symbolizer = OpenLayers.Util.applyDefaults(
		 {
         externalGraphic: "images/marker.png", 
         pointRadius: 20},
         
        OpenLayers.Feature.Vector.style["default"]);


var styleMap = new OpenLayers.StyleMap({"default": symbolizer, "select": {pointRadius: 30}});


var stationLayer = new OpenLayers.Layer.Vector("Registered Address Location", {styleMap: styleMap});



var point = new OpenLayers.Geometry.Point(90.589442834,23.2200971074);

var marker= new OpenLayers.Feature.Vector(point, null, {
	externalGraphic: "images/marker.png", 
    graphicWidth: 32,
    graphicHeight: 32,
    fillOpacity: 1
});

<g:each in="${addressLocationInfoInstanceList}" status="i" var="addressLocationInfo">

var point${addressLocationInfo.id}=dynamicStationLayer(${addressLocationInfo.alLongitude}, ${addressLocationInfo.alLatitude})

pointFeatures.attributes = {
	    longitude: ${addressLocationInfo.alLongitude},
	    latitude: ${addressLocationInfo.alLatitude}
	 
	};
	
pointFeatures.push(point${addressLocationInfo.id}); 
stationLayer.addFeatures(pointFeatures);

</g:each>


stationLayer.addFeatures(marker);

// thana Layer as WFS WS
var bdThana = new OpenLayers.Layer.Vector(
			            "Thana Information",
			            {
			                strategies: [new OpenLayers.Strategy.BBOX()]
			                , projection: new OpenLayers.Projection("EPSG:4326")
			                , protocol: new OpenLayers.Protocol.WFS({
			                    version: "1.1.0",
			                    url:  "http://localhost:7777/geoserver/BD_Climate_2/wfs", // geoserver URI/workspace name/format(wms or wfs)
			                    featurePrefix: "BD_Climate_2", //geoserver worspace name
			                    featureType: "bd_thana", //geoserver Layer Name
			                    featureNS: "http://bd.com/BD_Climate_2", // Edit Workspace Namespace URI Unique identifier
			                    isBaseLayer: false,
			                    visibility: false 
			                })
			            });


bdThana.events.on({
    featureselected: function(eventThana) {
        var feature = eventThana.feature;
        var thanaName = feature.attributes.thana_name;
        var divisionName = feature.attributes.div_name;
        var districtName = feature.attributes.dist_name;
        var area = feature.attributes.area;
        var longCoord = feature.attributes.coord_long;
        var latCoord = feature.attributes.coord_lati;
        
        var contentThana="<table border=1>"+
        "<th>Division Name</th>" +
        "<th>District Name</th>" +
        "<th>Thana Name</th>" +
        "<th>Total Area Sq.Km</th>" +
        "<th>Center Longitude</th>" +
        "<th>Center Latitude</th>" +
        
	   	"<tr><td>"+divisionName+"</td>" +
	   	"<td>"+districtName+"</td>" +
	   	"<td>"+thanaName+"</td>" +
	   	"<td>"+area+"</td>" +
	   	"<td>"+longCoord+"</td>" +
	   	"<td>"+latCoord+"</td></tr> </table>";
        document.getElementById("output_content_thana").innerHTML =contentThana;
    }
});


var vector_layer=new OpenLayers.Layer.Vector('Drawing Vector Layer');
			 
// Add all Layer in list
map.addLayers([osm,google_hybrid, gmap, google_satellite, google_terrian,bdThana,stationLayer,vector_layer]);
			     
			     var controls_arrays=[new OpenLayers.Control.Navigation(),
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


				 var selectThana = new OpenLayers.Control.SelectFeature([bdThana]);
					map.addControl(selectThana);
					selectThana.activate();
						 	
					 // add select feature control required to trigger events on the vector layer
				 var selectControlThana=new OpenLayers.Control.SelectFeature(bdThana, {
				       hover:true,
				       onSelect:function(featureThana){
				       
				       var layerThana=featureThana.layer;
				       featureThana.style.fillOpacity=1;
				       featureThana.style.pointRadius=20;
				       layerThana.drawFeature(featureThana);
				        
				    var contentThana="<table border=1><th>Division Name</th>" +
			        "<th>District Name</th>" +
			        "<th>Thana Name</th>" +
			        "<th>Total Area Sq.Km</th>" +
				   	"<tr><td>"+divisionName+"</td>" +
				   	"<td>"+districtName+"</td>" +
				   	"<td>"+thanaName+"</td>" +
				   	"<td>"+area+ "</td> </tr> </table>";
				       
				       var thanaPopup=new OpenLayers.Popup.FramedCloud(featureThana+"_popup",
				       featureThana.geometry.getBounds().getCenterLonLat(), new OpenLayers.Size(250, 100),contentThana,null,true);
				       featureThana.thanaPopup=thanaPopup;
				       map.addPopup(thanaPopup);
				       },
				       onUnSelect:function(featureThana){
				       var layerThana=featureThana.layer;
				       featureThana.style.fillOpacity=0.7;
				       featureThana.style.pointRadius=16;
				       featureThana.style.renderIntent=null;
				       layerThana.drawFeature(featureThana);
				       map.removePopup(featureThana.thanaPopup);
				       }
				       });
				  map.addControl(selectControlThana);
				  selectControlThana.activate();

					 
			       
			var click = new OpenLayers.Control.Click();
	             map.addControl(click);
	             click.activate();
	                
	      
			 map.setCenter(position, zoom );
             map.layers[1].features

              
                
 }
 </script>
 
 <style>
#output-id {margin: 10px 20px;}
</style>

  </head>

 <body onload="init()"> 
 
Registered Address Location: ${addressLocationInfoInstanceCount}

 <table>
 <tr>
 <td width="20%">Mouse Click Geo-Coordinate:
<table>
<th>Longitude</th>
<th>Latitude</th>
<tr>
<td><div id="longitude"></td>
<td><div id="latitude"></td>
</tr>					
</table>
</td>
<td>
<div id="map"  style='width: 900px; height:550px;'></div>
</td>
</tr>
</table>


<table>

		<tr>
			<td>Selected Feature Information:</td>
			<td></td>
		</tr>
		
		<tr>
			<td>
				<table>
					<tr>
					<td><div id="output_content_thana"> </td>
					</tr>
				</table>
			<td>
		</tr>
		
    </table>



 </body>
</html>