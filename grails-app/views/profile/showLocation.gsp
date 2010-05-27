<head>
  <!-- current key works for "http://localhost:8080/lernardo"
       needs to be changed for a different URL
       see http://code.google.com/intl/de/apis/maps/signup.html -->
  <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAAMf6ug3opWOHTRntmF0HUORQpnonm9ZMRIGlA6MOx1zXTLy0mlBSFYlI9GvM7c8rCBrY5gGIv8LiYuA" type="text/javascript"></script
  <script type="text/javascript">

    //<![CDATA[
    function load() {
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(${location.lat}, ${location.lng}), 13);
        map.addControl(new GLargeMapControl());
        map.addControl(new GMapTypeControl());

        var marker = new GMarker(new GLatLng(${location.lat}, ${location.lng}));
        marker.bindInfoWindowHtml("${entity.profile.fullName}<br/>${entity.profile.street}<br/>${entity.profile.PLZ} ${entity.profile.city}");
        map.addOverlay(marker)
      }
    }
    //]]>
  </script>
  <title>Standort</title>
  <meta name="layout" content="private"/>
</head>
<body>
<h1>Standort:</h1>
<p>Nachmittagsbetreuung ${entity.profile.city} - ${entity.profile.fullName}<br/>
  ${entity.profile.street}<br/>
  ${entity.profile.PLZ} ${entity.profile.city}</p>
<div id="map" style="width: 645px; height: 500px"></div>
</body>