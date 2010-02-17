  <head>
    <title>Lernardo | Hortkalender</title>
    <meta name="layout" content="private" />
    <g:javascript library="jquery" />
    <g:javascript src="jquery/jquery-ui-1.7.2.custom.min.js"/>
    <g:javascript src="jquery/fullcalendar-1.4.4.js"/>
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'fullcalendar-1.4.4.css')}" />
    <g:render template="/templates/calendar2" model="[name:name]"/>
  </head>

  <body>
    <div class="headerBlue">
      <h1>Pädagogen</h1>
    </div>
    <div class="boxGray">
        <div class="all" style="padding: 3px 4px"><g:link controller="calendar" action="showall">Alle</g:link></div>
        <g:each in="${paedList}" var="paed">
          <div class="${paed.name}" style="padding: 3px 4px"><g:link controller="calendar" action="showall" params="[name:paed.name]">${paed.profile.fullName}</g:link></div>
        </g:each>
    </div>
    <div class="headerBlue">
      <h1>Kalender</h1>
    </div>
    <div class="boxGray cal"></div>
  </body>

