<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Ereignisse</title>
</head>
<body>
  <g:if test="${entity.profile.showTips}">
    <div class="toolTip">
      <b><img src="${createLinkTo(dir:'images/icons',file:'icon_template.png')}" alt="toolTip" align="top"/>Tipp:</b> Ereignisse geben dir einen Überblick über deine Termine und Tätigkeiten.
    </div>
  </g:if>
  <div class="headerBlue">
    <h1>Ereignisse</h1>
  </div>
  <div class="boxGray">
    <p><span class="strong">Morgen</span></p>
    <p>
      <g:set var="count" value="0"/>
      <g:each in="${eventList}" var="event" status="i">
        <g:if test="${event.date.day == Calendar.getInstance().DAY_OF_MONTH+1}">
          <g:formatDate date="${event.date}" format="HH:mm"/> - ${event.content}<br/>
          <g:set var="count" value="${i}"/>
        </g:if>
      </g:each>
      <g:if test="${count == '0'}">
        <span class="italic">Keine Ereignisse für Morgen eingetragen!</span>
      </g:if>
    </p>
    <div class="cleartop"></div>

    <p><span class="strong">Heute (<g:formatDate date="${Calendar.getInstance().time}" format="dd.MM.yyyy"/>)</span></p>
    <p>
      <g:set var="count" value="0"/>
      <g:each in="${eventList}" var="event">
        <g:if test="${event.date.day == Calendar.getInstance().DAY_OF_MONTH}">
          <g:formatDate date="${event.date}" format="HH:mm"/> - ${event.content}<br/>
          <g:set var="count" value="${i}"/>
        </g:if>
      </g:each>
      <g:if test="${count == '0'}">
        <span class="italic">Keine Ereignisse für Heute eingetragen!</span>
      </g:if>
    </p>
    <div class="cleartop"></div>

    <p><span class="strong">Gestern</span></p>
    <p>
      <g:set var="count" value="0"/>
      <g:each in="${eventList}" var="event">
        <g:if test="${event.date.day == Calendar.getInstance().DAY_OF_MONTH-1}">
          <g:formatDate date="${event.date}" format="HH:mm"/> - ${event.content}<br/>
          <g:set var="count" value="${i}"/>
        </g:if>
      </g:each>
      <g:if test="${count == '0'}">
        <span class="italic">Keine Ereignisse für Gestern eingetragen!</span>
      </g:if>
    </p>
  </div>
</body>