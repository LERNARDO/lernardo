<div id="body-list" style="background-color: transparent">
  <h1>Meine Aktivitäten:</h1>  
  <g:if test="${!activityList}">
    <p>Keine Aktivitäten gefunden</p>
  </g:if>
  <g:else>
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
          <td><g:link controller="activity" action="show" id="${activity.id}">${activity.title}</g:link></td>
          <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.date}"/></td>
        </tr>
      </g:each>

      </tbody>
    </table>
  </g:else>
</div>