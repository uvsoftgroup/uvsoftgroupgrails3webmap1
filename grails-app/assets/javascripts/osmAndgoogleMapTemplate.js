var map;

function osmAndgoogleMapTemplate(px,py){
	
	 var pointFeatures=[];

       // The location of our marker and popup. We usually think in geographic coordinates ('EPSG:4326'), but the map is projected ('EPSG:3857')
	 var mapCenterPoint=new OpenLayers.Geometry.Point(90.00, 24.00).transform('EPSG:4326', 'EPSG:900913');
  
   var gmap = new OpenLayers.Layer.Google("Google Streets");
   // to get google hybrid map
   var google_hybrid=new OpenLayers.Layer.Google("Google Hybrid",
   { type: google.maps.MapTypeId.HYBRID}
   );
   // to get google terrain map
   var google_terrian=new OpenLayers.Layer.Google("Google Terrain",
   { type: google.maps.MapTypeId.TERRAIN}
   );
   // to get google satellite map
   var google_satellite=new OpenLayers.Layer.Google("Google Satellite",
   { type: google.maps.MapTypeId.SATELLITE}
   );
   
  // to make station or site layer 
  var stationLayer=new OpenLayers.Layer.Vector("Station or Site", {
	  projection:"EPSG:900913"
	  });
	  
		// to make link layer 
  var linkLayer=new OpenLayers.Layer.Vector("Station or Site Link");
		// to make Coverage layer 
  var coverAreaRadiusLayer=new OpenLayers.Layer.Vector("Service Coverage Area");
  
  // to get the osm layer
  var osm=new OpenLayers.Layer.OSM();
  var editablelayer = new OpenLayers.Layer.Vector("Measurement and Calculation");
  
  // all layers are added into the map
  var addedlayers=[osm, stationLayer,linkLayer,coverAreaRadiusLayer,editablelayer, gmap, google_hybrid, google_terrian, google_satellite];
 
  var point=dynamicStationPointLayer(px,py);
  pointFeatures.push(point);
  stationLayer.addFeatures(pointFeatures);
  
  
  
  var controls_arrays=[
                       new OpenLayers.Control.Navigation({}),
                       new OpenLayers.Control.PanZoomBar({}),
                       new OpenLayers.Control.LayerSwitcher({div: document.getElementById('layer_switcher_control'), roundedCorner: false}),
                       new OpenLayers.Control.Permalink({}),
                       new OpenLayers.Control.MousePosition({}),
                       new OpenLayers.Control.ScaleLine({}),
                       new OpenLayers.Control.KeyboardDefaults({}),
                       new OpenLayers.Control.Graticule({}),
                       new OpenLayers.Control.Scale({}),
                       new OpenLayers.Control.EditingToolbar(editablelayer),
                       new OpenLayers.Control.OverviewMap({maximized: true})
                       //new OpenLayers.Control.NavigationHistory({}),
                       ];
  
       // Finnaly we sreate the map
       map=new OpenLayers.Map({
             div:"map",
             controls:controls_arrays,
             projection:"EPSG:4326",
             layers:addedlayers,
             displayProjection:"EPSG:4326",
             center:mapCenterPoint.getBounds().getCenterLonLat(),
             zoom:7
             });
       
       
       // add select feature control required to trigger events on the vector layer
       var selectControl=new OpenLayers.Control.SelectFeature(stationLayer, {
        hover:false,
        onSelect:function(feature){
        
        var layer=feature.layer;
        feature.style.fillOpacity=1;
        feature.style.pointRadius=20;
        layer.drawFeature(feature);
    	  
     var content="<table border=1><th>Station for Mobile communication:</th>" +
    	"<tr><td>Licensee Name:</td><td>Govet Indonesia</td></tr> " +
    	"<tr><td>Service Name:</td><td>Fixed Service</td></tr> " +
    	"<tr><td>Sub-Service Name:</td><td>Point to Point</td></tr> " +
    	"<tr><td>License Name:</td><td>Govet Indonesia 00001</td> </tr> " +
    	"<tr><td>License Status:</td><td>Govet Indonesia Live</td> </tr> " +
    	"<tr><td>Station Name:</td><td>Govet Indonesia Centeral Station 01</td> </tr> " +
    	"<tr><td>Station Type:</td><td>Govet Indonesia Centeral Station Base </td> </tr> " +
    	"<tr><td>Equipment Model:</td><td>Erricson tt66688</td> </tr> " +
    	"<tr><td>Equipment Manufacturer:</td><td>Erricson</td> </tr> " +
    	"<tr><td>Equipment Serial Number:</td><td>ER888888888888</td> </tr> " +
    	"<tr><td>Frequency:</td><td>16.888 MHz</td> </tr> " +
    	"<tr><td>Antenna Type:</td><td>Directional</td> </tr> " +
    	"<tr><td>Mean Sea Level Height:</td><td>2.01 M</td> </tr> " +
    	"<tr><td>Antenna Height from MSL:</td><td>30.01 M</td> </tr> </table>";
        
        
        var popup2=new OpenLayers.Popup.FramedCloud(feature.id+"_popup",
        feature.geometry.getBounds().getCenterLonLat(),
        new OpenLayers.Size(250, 100),
        content,
        null,
        true);
        feature.popup2=popup2;
        map.addPopup(popup2);
        },
        onUnSelect:function(feature){
        var layer=feature.layer;
        feature.style.fillOpacity=0.7;
        feature.style.pointRadius=16;
        feature.style.renderIntent=null;
        layer.drawFeature(feature);
        map.removePopup(feature.popup2);
        }
        });
        
       map.addControl(selectControl);
       selectControl.activate();
                  
  
} 
