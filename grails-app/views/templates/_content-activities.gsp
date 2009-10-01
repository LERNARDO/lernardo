<div id="yui-main">
  <div class="yui-b">
    <div id="profile-content">
      <div id="body-list" style="background-color: transparent">
        <h1>Meine Aktivitäten:</h1>
        <g:if test="${activityList.size() == 0}">
          <p>Keine Aktivitäten gefunden</p>
        </g:if>
        <g:else>
          <table id="profile-list">
            <thead>
              <tr>
            <g:sortableColumn property="title" title="Aktivität" />
            <g:sortableColumn property="date" title="Datum" />
            <g:sortableColumn property="startTime" title="Startzeit" />
            </tr>
            </thead>
            <tbody>

            <g:each status="i" in="${activityList}" var="activityInstance">
              <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
                <td><g:link controller="activity" action="show" id="${activityInstance.value.id}">${activityInstance.value.title}</g:link></td>
              <td>${activityInstance.value.date}</td>
              <td>${activityInstance.value.startTime}</td>
              </tr>
            </g:each>

            </tbody>
          </table>
        </g:else>
      </div>
    </div><!--profile-content"-->
  </div><!--yui-b-->
</div><!--yui-main-->