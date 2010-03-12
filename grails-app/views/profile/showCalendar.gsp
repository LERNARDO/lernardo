<head>
  <title>Lernardo | Kalender</title>
  <meta name="layout" content="private"/>
  <g:javascript library="jquery" />
  <g:javascript src="jquery/fullcalendar.js"/>
  <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'fullcalendar.css')}" />
  <g:render template="/templates/calendar" model="[name:name]"/>
</head>

<body>
  <div class="headerBlue">
    <h1>Kalender von ${entity.profile.fullName}</h1>
  </div>
  <div class="boxGray cal"></div>
</body>