<div class="info-msg">
  <g:message code="object.found" args="[totalTemplates, message(code: 'groupActivityTemplates')]"/>
</div>

<table class="default-table">
  <thead>
  <tr>
    <util:remoteSortableColumn property="fullName" title="${message(code:'name')}" action="updateselect2" update="templateselect" params="[name: name,
                                              duration1: duration1, duration2: duration2]"/>
    <th><g:message code="numberOfActivityTemplates"/></th>
    <util:remoteSortableColumn property="realDuration" title="${message(code:'totalDuration')}" action="updateselect2" update="templateselect" params="[name: name,
                                              duration1: duration1, duration2: duration2]"/>
    <th><g:message code="creator"/></th>
  </tr>
  </thead>

  <tbody>
  <g:each status="i" in="${allTemplates}" var="templateInstance">
    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
      <td><g:link action="show" id="${templateInstance.id}">${templateInstance.profile.decodeHTML()}</g:link></td>
      <td><erp:getGroupSize entity="${templateInstance}"/></td>
      <td>${fieldValue(bean: templateInstance, field: 'profile.realDuration')}</td>
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