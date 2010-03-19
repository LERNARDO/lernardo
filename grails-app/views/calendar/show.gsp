<head>
  <title>Lernardo | Einrichtungskalender</title>
  <meta name="layout" content="private-cal" />
  <g:javascript library="jquery" />
  <g:javascript src="jquery/fullcalendar.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}" />
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
      <g:each in="${educators}" var="educator">
        <div style="padding: 3px 4px"><img src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="toolTip" align="top"/> <g:link controller="calendar" action="show" id="${educator.id}">${educator.profile.fullName}</g:link></div>
      </g:each>
    </div>
  </div>
  <div class="headerBlue">
    <div class="second">
      <h1>Kalender von ${active.profile.fullName}</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second cal"></div>
  </div>
</body>

