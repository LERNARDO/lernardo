<div class="info-msg">
  <g:message code="object.found" args="[totalTemplates, message(code: 'projectTemplates')]"/>
</div>

<table class="default-table">
  <thead>
  <tr>
    <util:remoteSortableColumn property="fullName" title="${message(code:'name')}" action="updateselect" update="templateselect" params="[name: name]"/>
    <util:remoteSortableColumn property="status" title="${message(code:'status')}" action="updateselect" update="templateselect" params="[name: name]"/>
    <th><g:message code="projectUnitTemplates"/></th>
    <th><g:message code="creator"/></th>
  </tr>
  </thead>

  <tbody>
  <g:each status="i" in="${allTemplates}" var="templateInstance">
    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
      <td><g:link action="show" id="${templateInstance.id}">${templateInstance.profile.decodeHTML()}</g:link></td>
      <td><g:message code="status.${templateInstance.profile.status}"/></td>
      <td><erp:getProjectTemplateUnitsCount template="${templateInstance}"/></td>
      <td><erp:createdBy entity="${templateInstance}">${creator?.profile?.decodeHTML()}</erp:createdBy></td>
    </tr>
  </g:each>
  </tbody>
</table>

<g:if test="${paginate}">
  <div class="paginateButtons">
    <g:paginate action="list" total="${totalTemplates}"/>
  </div>
</g:if>