<head>
  <title>Einrichtungskalender</title>
  <meta name="layout" content="private-cal" />
  <g:javascript library="jquery" />
  <g:javascript src="jquery/fullcalendar.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}" />
  <g:render template="/templates/calendar" model="[id:id]"/>
</head>

<body>

  <div class="headerGreen">
    <div class="second">
      <h1>Legende</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <span style="background: #5b5; padding: 5px; color: #fff">Themen</span>
      <span style="background: #55b; padding: 5px; color: #fff">Aktivitätsgruppen</span>
      <span style="background: #b55; padding: 5px; color: #fff">Themenraumaktivitäten</span>
    </div>
  </div>

  <div class="headerGreen">
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

  <div class="headerGreen">
    <div class="second">
      <h1>Kalender von ${active.profile.fullName}</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second cal"></div>
  </div>
</body>

