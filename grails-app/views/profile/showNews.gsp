<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="events"/></title>
</head>

<body>
<g:if test="${entity.profile.showTips}">
  <div class="toolTip" id="tooltip">
    <div class="second">
      <span class="bold"><img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><g:message code="hint"/></span> <g:message code="tooltip.news"/>
      <span style="float: right"><a onclick="toggle('#tooltip'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'cross.png')}" alt="Close"/></a></span>
    </div>
  </div>
</g:if>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="events"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p><span class="strong"><g:message code="tomorrow"/></span></p>
    <p>
      <g:if test="${eventsTomorrow}">
        <g:each in="${eventsTomorrow}" var="event" status="i">
          <g:formatDate date="${event.date}" format="HH:mm" timeZone="${timeZone}"/> - ${event.content.decodeHTML()}<br/>
        </g:each>
      </g:if>
      <g:else>
        <span class="italic"><g:message code="profile.showNews.tomorrowMsg"/></span>
      </g:else>
    </p>
    <div class="cleartop"></div>

    <p><span class="strong"><g:message code="today"/> (<g:formatDate date="${Calendar.getInstance().time}" format="dd.MM.yyyy"/>)</span></p>
    <p>
      <g:if test="${eventsToday}">
        <g:each in="${eventsToday}" var="event" status="i">
          <g:formatDate date="${event.date}" format="HH:mm" timeZone="${timeZone}"/> - ${event.content.decodeHTML()}<br/>
        </g:each>
      </g:if>
      <g:else>
        <span class="italic"><g:message code="profile.showNews.todayMsg"/></span>
      </g:else>
    </p>
    <div class="cleartop"></div>

    <p><span class="strong"><g:message code="yesterday"/></span></p>
    <p>
      <g:if test="${eventsYesterday}">
        <g:each in="${eventsYesterday}" var="event" status="i">
          <g:formatDate date="${event.date}" format="HH:mm" timeZone="${timeZone}"/> - ${event.content.decodeHTML()}<br/>
        </g:each>
      </g:if>
      <g:else>
        <span class="italic"><g:message code="profile.showNews.yesterdayMsg"/></span>
      </g:else>
    </p>
    
  </div>
</div>
</body>