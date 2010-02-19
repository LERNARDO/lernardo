<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Aktivitäten</title>
</head>
<body>
  <g:if test="${entity.profile.showTips}">
    <div class="toolTip">
      <b><img src="${createLinkTo(dir:'images/icons',file:'icon_template.png')}" alt="toolTip"/>Tipp:</b> Diese Seite bietet einen Überblick über alle Aktivitäten an denen du teilnimmst.
    </div>
  </g:if>
  <div class="headerBlue">
    <h1>Aktivitäten</h1>
  </div>
  <div class="boxGray">
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
              <td><g:link controller="activity" action="show" id="${activity.id}" params="[name:entity.name]">${activity.title}</g:link></td>
              <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.date}"/></td>
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
</body>

