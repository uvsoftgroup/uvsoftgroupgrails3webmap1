<!DOCTYPE html>
<html>
 <head>
  <meta name="layout" content="main"/>
  <title>Urban Management System</title>
  <style type="text/css" media="screen">
   #status {
    background-color: #eee;
    border: .2em solid #fff;
    margin: 2em 2em 1em;
    padding: 1em;
    width: 25em;
    float: left;
    -moz-box-shadow: 0px 0px 1.25em #ccc;
    -webkit-box-shadow: 0px 0px 1.25em #ccc;
    box-shadow: 0px 0px 1.25em #ccc;
    -moz-border-radius: 0.6em;
    -webkit-border-radius: 0.6em;
    border-radius: 0.6em;
   }

   .ie6 #status {
    display: inline; / float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html /
   }

   #status ul {
    font-size: 0.9em;
    list-style-type: none;
    margin-bottom: 0.6em;
    padding: 0;
   }

   #status li {
    line-height: 1.3;
   }

   #status h1 {
    text-transform: uppercase;
    font-size: 1.1em;
    margin: 0 0 0.3em;
   }

   #page-body {
    margin: 2em 1em 1.25em 18em;
   }

   h2 {
    margin-top: 1em;
    margin-bottom: 0.3em;
    font-size: 1em;
   }

   p {
    line-height: 1.5;
    margin: 0.25em 0;
   }

   #controller-list ul {
    list-style-position: inside;
   }

   #controller-list li {
    line-height: 1.3;
    list-style-position: inside;
    margin: 0.25em 0;
   }

   @media screen and (max-width: 480px) {
    #status {
     display: none;
    }

    #page-body {
     margin: 0 1em 1em;
    }

    #page-body h1 {
     margin-top: 0;
    }
   }
  </style>
 </head>
 <body>
<h4>Welcome to UVSoftGroup</h4>
<p>Congratulations, we have successfully started your Grails3 application with below technologies: <br></p>
<table>
  <tr>
  <td></td>
  <td></td>
  <td></td>
   <td></td>
   <td></td>
   <td></td>
   <td>Java and Groovy</td>
 </tr>
  <tr>
        <td></td>
       <td></td>
       <td></td>
       <td></td>
       <td></td>
        <td></td>
    <td>Grails3</td>
  </tr>

  <tr>
         <td></td>
         <td></td>
         <td></td>
         <td></td>
         <td></td>
         <td></td>
      <td>GeoServer(Application Server)</td>
    </tr>
      <tr>
          <td></td>
             <td></td>
             <td></td>
             <td></td>
              <td></td>
              <td></td>
          <td>PostgreSQL with PostGIS (Backend Server)</td>
        </tr>
          <tr>
              <td></td>
                 <td></td>
                 <td></td>
                 <td></td>
                                           <td></td>
                                           <td></td>
              <td>ESRI shapefile(Geospatial file system datasets)</td>
            </tr>
              <tr>
                     <td></td>
                     <td></td>
                     <td></td>
                     <td></td>
                     <td></td>
                     <td></td>
                  <td>Map APIs(Google Map APIs & OpenLayer JavaScript APIs )</td>
                </tr>
      <tr>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                       <td>Google map dataset & OpenStreetMap</td>
                     </tr>

</table>

 <g:link controller="webmaps" action="createVectorLayer">
 <input type="button" value="<g:message code="mapapplication.label"/>"
 </g:link>
 <g:link controller="webmaps" action="geoserverApplication">
 <input type="button" value="<g:message code="geoserverapplication.label"/>"
 </g:link>

</body>
</html>