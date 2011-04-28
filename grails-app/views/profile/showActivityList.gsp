<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Aktivitäten</title>
</head>
<body>
<g:if test="${entity.profile.showTips}">
  <div class="toolTip" id="tooltip">
    <div class="second">
      <span class="bold"><img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><g:message code="hint"/></span> <g:message code="tooltip.myActivities"/>
      <span style="float: right"><a onclick="toggle('#tooltip'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'cross.png')}" alt="Close"/></a></span>
    </div>
  </div>
</g:if>
<div class="headerBlue">
  <div class="second">
    <h1>Aktivitäten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div id="body-list">
      <g:if test="${!activityList}">
        <p>Keine Aktivitäten gefunden.</p>
      </g:if>
      <g:else>
        <p>${activityCount} Aktivitäten gefunden</p>
        <table id="profile-list">
          <thead>
          <tr>
            <g:sortableColumn property="title" title="Aktivität"/>
            <g:sortableColumn property="date" title="Datum"/>
          </tr>
          </thead>
          <tbody>

          <g:each status="i" in="${activityList}" var="activity">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
              <td><g:link controller="activityProfile" action="show" id="${activity.id}" params="[name:entity.name]">${activity.title}</g:link></td>
              <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.date}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
            </tr>
          </g:each>

          </tbody>
        </table>
      </g:else>

      <div class="paginateButtons">
        <g:paginate action="showActivityList" total="${activityCount}" params="[name:entity.name]"/>
      </div>

    </div>
  </div>
</div>
</body>

