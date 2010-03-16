<head>
  <title>Lernardo | Einrichtungskalender</title>
  <meta name="layout" content="private" />
  <g:javascript library="jquery" />
  <g:javascript src="jquery/fullcalendar.js"/>
  <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'fullcalendar.css')}" />
  <g:render template="/templates/calendar" model="[id:id]"/>
</head>

<body>
  <div class="headerBlue">
    <div class="second">
      <h1>Pädagogen</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <div style="padding: 3px 4px"><g:link controller="calendar" action="show">Mein Kalender</g:link></div>
      <g:each in="${educators}" var="educator">
        <div style="padding: 3px 4px"><g:link controller="calendar" action="show" id="${educator.id}">${educator.profile.fullName}</g:link></div>
      </g:each>
    </div>
  </div>
  <div class="headerBlue">
    <div class="second">
      <h1>Kalender</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second cal"></div>
  </div>
</body>

