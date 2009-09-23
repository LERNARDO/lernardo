<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste aller Aktivitäten</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste aller Aktivitäten</h2>
      <p>${totalActivities} Aktivitäten gefunden</p>

      <table>
        <thead>
          <tr>
        <g:sortableColumn property="actionID" title="Aktivitätsvorlage" />
        <g:sortableColumn property="date" title="Datum" />
        <g:sortableColumn property="startTime" title="Startzeit" />
        <g:sortableColumn property="duration" title="Dauer" />
        <g:sortableColumn property="paedList" title="teilnehmende Pädagogen" />
        <g:sortableColumn property="clientList" title="teilnehmende Betreute" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${activityList}" var="activityInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td>${activityInstance.value.actionID}</td>
            <td>${activityInstance.value.date}</td>
            <td>${activityInstance.value.startTime}</td>
            <td>${activityInstance.value.duration}</td>
            <td>
          <g:each in="${activityInstance.value.paedList}" var="paedListInstance">
${paedListInstance}<br>
          </g:each>
          </td>
          <td>
          <g:each in="${activityInstance.value.clientList}" var="clientListInstance">
${clientListInstance}<br>
          </g:each>
          </td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate controller="admin"
                    action="listActivities"
                    total="${totalActivities}" />
      </div>

    </div>
  </body>
</html>