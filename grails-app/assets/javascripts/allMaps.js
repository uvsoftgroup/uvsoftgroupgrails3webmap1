 function allMaps() {
	
	var options = {
    projection: new OpenLayers.Projection("EPSG:900913"),
    units: "m",
    maxResolution: 156543.0339,
    maxExtent: new OpenLayers.Bounds(-20037508.34, -20037508.34,
                                     20037508.34, 20037508.34)
    };
    map = new OpenLayers.Map("maps", options);
 
    
	var mapnik= new OpenLayers.Layer.OSM();
	map.addLayer(mapnik);
		
    var fromProjection = new OpenLayers.Projection("EPSG:4326");   // Transform from WGS 1984
    var toProjection   = new OpenLayers.Projection("EPSG:900913"); // to Spherical Mercator Projection
    var position       = new OpenLayers.LonLat(90.400558, 23.794455).transform( fromProjection, toProjection);	
    var zoom           = 5;   	
					
	 //to get google hybrid map
    var google_hybrid=new OpenLayers.Layer.Google("Google Hybrid",
     { type: google.maps.MapTypeId.HYBRID}
     );
	map.addLayer(google_hybrid);
	 
	 // to get google Streets map
	var gmap = new OpenLayers.Layer.Google("Google Streets");
	map.addLayer(gmap);
	 
	// to get google Satellite map 
    var google_satellite=new OpenLayers.Layer.Google("Google Satellite",
     { type: google.maps.MapTypeId.SATELLITE}
     ); 
	 map.addLayer(google_satellite);

   // to get google terrain map
    var google_terrian=new OpenLayers.Layer.Google("Google Terrain",
     { type: google.maps.MapTypeId.TERRAIN}
     );
     map.addLayer(google_terrian);
	 
	 map.addControl(new OpenLayers.Control.LayerSwitcher());
	 map.addControl(new OpenLayers.Control.MousePosition());
	 map.addControl(new OpenLayers.Control.Navigation());
     map.addControl(new OpenLayers.Control.PanZoomBar());
     map.addControl(new OpenLayers.Control.MousePosition({}));
     map.addControl(new OpenLayers.Control.ScaleLine({}));
     map.addControl(new OpenLayers.Control.EditingToolbar({}));
     
     map.addControl(new OpenLayers.Control.KeyboardDefaults({}));
     map.addControl(new OpenLayers.Control.OverviewMap({maximized: true}));
	 map.addControl(new OpenLayers.Control.SelectFeature({}));
	
	map.setCenter(position, zoom );
    }