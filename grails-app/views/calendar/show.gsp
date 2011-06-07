<head>
  <title><g:message code="cal.title"/></title>
  <meta name="layout" content="private-cal" />
</head>

<body>

<div id="caltip"></div>

  %{--<div class="boxHeader">
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

  <div class="boxHeader">
    <div class="second">
      <h1><g:message code="imgmenu.calendar.name"/></h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second cal" id="calendar">
        <g:render template="calendar"/>
    </div>
  </div>

</body>

