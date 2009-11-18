<head>
  <!-- current key works for "http://localhost:8080/lernardoV2"
       needs to be changed for a different URL
       see http://code.google.com/intl/de/apis/maps/signup.html -->
  <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAMf6ug3opWOHTRntmF0HUORR4NdFV4mo7weW64bVQX_uxHpRW5hSDUy6eeUOVRTZf9GNYU1A1KszcmQ" type="text/javascript"></script
  <script type="text/javascript">

  //<![CDATA[
    function load() {
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map"));
        map.setCenter(new GLatLng(${location.lat},${location.lng}), 13);
        map.addControl(new GLargeMapControl())
        map.addControl(new GMapTypeControl())

        var marker = new GMarker(new GLatLng(${location.lat},${location.lng}))
        marker.bindInfoWindowHtml("${profileInstance.fullName}<br/>${profileInstance.strasse}<br/>${profileInstance.plz} ${profileInstance.ort}")
        map.addOverlay(marker)
      }
    }
  //]]>
  </script>
</head>

<div id="yui-main">
  <div class="yui-b">
    <div id="profile-content">
      <h1>Standort:</h1>
      <p>Nachmittagsbetreuung ${profileInstance.ort} - ${profileInstance.fullName}<br/>
        ${profileInstance.strasse}<br/>
        ${profileInstance.plz} ${profileInstance.ort}</p>
      <div id="map" style="width: 645px; height: 500px"></div>
    </div><!--profile-content-->
  </div><!--yui-b-->
</div><!--yui-main-->