<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Kalender</title>
  <g:javascript library="jquery" />
  <g:javascript src="jquery/jquery-ui-1.7.2.custom.min.js"/>
  <g:javascript src="jquery/fullcalendar-1.4.4.js"/>
  <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'fullcalendar-1.4.4.css')}" />
  <g:render template="/templates/calendar2" model="[name:name]"/>
</head>

<body>
  <div class="headerBlue">
    <h1>Kalender</h1>
  </div>
  <div class="boxGray cal"></div>
</body>