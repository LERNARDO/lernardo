<head>
  <title>Kalender</title>
  <meta name="layout" content="private"/>
  <g:javascript src="jquery/fullcalendar.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}" />
  <g:render template="/templates/calendar" model="[name:name]"/>
</head>

<body>
  <div class="headerBlue">
    <div class="second">
      <h1>Kalender von ${entity.profile.fullName}</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second cal"></div>
  </div>
</body>