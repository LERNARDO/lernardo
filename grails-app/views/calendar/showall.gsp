
  <head>
    <title>Kalender: Lernardo Gesamt</title>
    <meta name="layout" content="private" />
    <g:javascript library="jquery" />
    <g:javascript src="jquery/jquery-ui-1.7.2.custom.min.js"/>
    <g:javascript src="jquery/jquery.fullcalendar.js"/>
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'jquery.fullcalendar.css')}" />
    <g:render template="/templates/calendar2" model="[name:name]"/>

  </head>

  <body>
      <div class="profile-group" style="width:250px;">Lernardo - Gesamt</div>
      <div class="profile-box">
        <div id="profile-content"></div>
      </div>
  </body>