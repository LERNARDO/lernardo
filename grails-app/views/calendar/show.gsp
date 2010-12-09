<head>
  <title><g:message code="cal.title"/></title>
  <meta name="layout" content="private-cal" />
  <g:javascript library="jquery" />  
  <g:javascript src="jquery/fullcalendar.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}" />
  <g:render template="/templates/calendar" model="[visibleEducators: visibleEducators]"/>
</head>

<body>

<div id="caltip"></div>

  %{--<div class="headerGreen">
    <div class="second">
      <h1><g:message code="cal.caption"/></h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <div style="margin: 5px 0 5px 0">
        <span style="background: #5b5; padding: 5px; color: #fff; -moz-border-radius: 2px; margin: 0 3px 0 0;"><g:message code="cal.theme"/></span>
        <span style="background: #55b; padding: 5px; color: #fff; -moz-border-radius: 2px; margin: 0 3px 0 0;"><g:message code="cal.groupActivity"/></span>
        <span style="background: #b55; padding: 5px; color: #fff; -moz-border-radius: 2px; margin: 0 3px 0 0;"><g:message code="cal.activityInstance"/></span>
        <span style="background: #bb5; padding: 5px; color: #fff; -moz-border-radius: 2px; margin: 0 3px 0 0;"><g:message code="cal.projectUnit"/></span>
      </div>
    </div>
  </div>--}%

  <div class="headerGreen">
    <div class="second">
      <h1><g:message code="educators"/></h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <g:each in="${educators}" var="educator" status="i">
        <app:getActiveEducator educators="${visibleEducators}" id="${educator.id}">
          <div class="calendereducator" style="background: ${active ? grailsApplication.config.colors[i] : ''}"><g:link style="display: block; color: ${active ? '#fff' : '#000'}; text-decoration: none;" controller="calendar" action="show" id="${educator.id}" params="[visibleEducators: visibleEducators]"><img src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="toolTip" align="top"/> ${educator.profile.fullName}</g:link></div>
        </app:getActiveEducator>
      </g:each>
      <div class="clear"></div>
    </div>
  </div>

  <div class="headerGreen">
    <div class="second">
      <h1>Kalender</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second cal"></div>
  </div>
</body>

