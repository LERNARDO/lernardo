<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="events"/></title>
</head>
<body>
<g:if test="${entity.profile.showTips}">
  <div class="toolTip">
    <div class="second">
      <b><img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><g:message code="tipp"/> </b> <g:message code="profile.showNews.tipp"/>
    </div>
  </div>
</g:if>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="events"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p><span class="strong"><g:message code="tomorrow"/></span></p>
    <p>
      <g:set var="count" value="0"/>
      <g:each in="${eventList}" var="event" status="i">
        <g:if test="${event.date.day == Calendar.getInstance().DAY_OF_MONTH+1}">
          <g:formatDate date="${event.date}" format="HH:mm"/> - ${event.content}<br/>
          <g:set var="count" value="${i}"/>
        </g:if>
      </g:each>
      <g:if test="${count == '0'}">
        <span class="italic"><g:message code="profile.showNews.tomorrowMsg"/></span>
      </g:if>
    </p>
    <div class="cleartop"></div>

    <p><span class="strong"><g:message code="today"/> (<g:formatDate date="${Calendar.getInstance().time}" format="dd.MM.yyyy"/>)</span></p>
    <p>
      <g:set var="count" value="0"/>
      <g:each in="${eventList}" var="event">
        <g:if test="${event.date.day == Calendar.getInstance().DAY_OF_MONTH}">
          <g:formatDate date="${event.date}" format="HH:mm"/> - ${event.content}<br/>
          <g:set var="count" value="${i}"/>
        </g:if>
      </g:each>
      <g:if test="${count == '0'}">
        <span class="italic"><g:message code="profile.showNews.todayMsg"/></span>
      </g:if>
    </p>
    <div class="cleartop"></div>

    <p><span class="strong"><g:message code="yesterday"/></span></p>
    <p>
      <g:set var="count" value="0"/>
      <g:each in="${eventList}" var="event">
        <g:if test="${event.date.day == Calendar.getInstance().DAY_OF_MONTH-1}">
          <g:formatDate date="${event.date}" format="HH:mm"/> - ${event.content}<br/>
          <g:set var="count" value="${i}"/>
        </g:if>
      </g:each>
      <g:if test="${count == '0'}">
        <span class="italic"><g:message code="profile.showNews.yesterdayMsg"/></span>
      </g:if>
    </p>
  </div>
</div>
</body>