<head>
  <title><g:message code="cal.title"/></title>
  <meta name="layout" content="private-cal" />
  <g:javascript library="jquery" />  
  <g:javascript src="jquery/fullcalendar.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}" />
  <g:render template="/templates/calendar" model="[id:id]"/>
</head>

<body>

  <div class="headerGreen">
    <div class="second">
      <h1><g:message code="cal.caption"/></h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <span style="background: #5b5; padding: 5px; color: #fff"><g:message code="cal.theme"/></span>
      <span style="background: #55b; padding: 5px; color: #fff"><g:message code="cal.groupActivity"/></span>
      <span style="background: #b55; padding: 5px; color: #fff"><g:message code="cal.activityInstance"/></span>
    </div>
  </div>

  <div class="headerGreen">
    <div class="second">
      <h1><g:message code="educator"/></h1>
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
      <h1><g:message code="cal.owned"/> ${active.profile.fullName}</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second cal"></div>
  </div>
</body>

