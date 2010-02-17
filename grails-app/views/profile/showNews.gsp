<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Ereignisse</title>
</head>
<body>
<div class="headerBlue">
  <h1>Ereignisse</h1>
</div>
<div class="boxGray">
<p><span class="strong">Morgen</span></p>
<p>
  <g:each in="${eventList}" var="event">
    <g:if test="${event.date.day == Calendar.getInstance().DAY_OF_MONTH}">
      <g:formatDate date="${event.date}" format="HH:mm"/> - ${event.content}<br/>
    </g:if>
  </g:each>
</p>
<div class="cleartop"></div>

<p><span class="strong">Heute (<g:formatDate date="${Calendar.getInstance().time}" format="dd.MM.yyyy"/>)</span></p>
<p>
  <g:each in="${eventList}" var="event">
    <g:if test="${event.date.day == Calendar.getInstance().DAY_OF_MONTH-1}">
      <g:formatDate date="${event.date}" format="HH:mm"/> - ${event.content}<br/>
    </g:if>
  </g:each>
</p>
<div class="cleartop"></div>

<p><span class="strong">Gestern</span></p>
<p>
  <g:each in="${eventList}" var="event">
    <g:if test="${event.date.day == Calendar.getInstance().DAY_OF_MONTH-2}">
      <g:formatDate date="${event.date}" format="HH:mm"/> - ${event.content}<br/>
    </g:if>
  </g:each>
</p>
</div>
</body>