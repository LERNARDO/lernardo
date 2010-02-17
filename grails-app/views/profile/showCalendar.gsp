<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Kalender</title>
  <g:javascript library="jquery" />
  <g:javascript src="jquery/jquery-ui-1.7.2.custom.min.js"/>
  <g:javascript src="jquery/jquery.fullcalendar.js"/>
  <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'jquery.fullcalendar.css')}" />
  <g:render template="/templates/calendar2" model="[name:name]"/>
</head>

<body>
  <div class="headerBlue">
    <h1>Kalender</h1>
  </div>
  <div class="boxGray cal"></div>
</body>