<p>${allTemplates.size()} <g:message code="activityTemplate.c_total"/></p>

<table class="default-table">
  <thead>
  <tr>
    <g:sortableColumn property="fullName" title="Name"/>
    <g:sortableColumn property="duration" title="Dauer (min)"/>
    <g:sortableColumn property="socialForm" title="Sozialform"/>
    <th>Kommentare</th>
  </tr>
  </thead>

  <tbody>
  <g:each status="i" in="${allTemplates}" var="templateInstance">
    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
      <td><g:link action="show" id="${templateInstance.id}" params="[entity: templateInstance.id]">${templateInstance.profile.fullName.decodeHTML()}</g:link></td>
      <td>${templateInstance.profile.duration}</td>
      <td>${templateInstance.profile.socialForm}</td>
      <td>${templateInstance.profile.comments.size()}</td>
    </tr>
  </g:each>
  </tbody>
</table>


<div class="paginateButtons">
  <g:paginate action="list" total="${allTemplates.size()}"/>
</div>