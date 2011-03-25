<div class="info-msg">
  <g:message code="activityTemplate.c_total" args="[totalTemplates, numberOfAllTemplates ?: totalTemplates]"/>
</div>

<div class="buttons">
  <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']">
    <g:link class="buttonGreen" controller="templateProfile" action="create"><g:message code="activityTemplate.create"/></g:link>
    <div class="spacer" style="margin-bottom: 5px"></div>
  </erp:accessCheck>
</div>

<table class="default-table">
  <thead>
  <tr>
    %{--<g:sortableColumn property="fullName" title="${message(code:'name')}"/>
    <g:sortableColumn property="duration" title="${message(code:'duration')} (min)"/>
    <g:sortableColumn property="socialForm" title="${message(code:'activityTemplate.socialForm')}"/>--}%
    <th><g:message code="name"/></th>
    <th><g:message code="duration"/> (min)</th>
    <th><g:message code="activityTemplate.socialForm"/></th>
    <th><g:message code="comments"/></th>
    <th><g:message code="creator"/></th>
  </tr>
  </thead>

  <tbody>
  <g:each status="i" in="${allTemplates}" var="templateInstance">
    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
      <td><g:link action="show" id="${templateInstance.id}" params="[entity: templateInstance.id]">${templateInstance.profile.fullName.decodeHTML()}</g:link></td>
      <td>${templateInstance.profile.duration}</td>
      <td><g:message code="socialForm.${templateInstance.profile.socialForm}"/></td>
      <td>${templateInstance.profile.comments.size()}</td>
      <td><erp:createdBy entity="${templateInstance}">${creator?.profile?.fullName?.decodeHTML()}</erp:createdBy></td>
    </tr>
  </g:each>
  </tbody>
</table>

<g:if test="${paginate}">
  <div class="paginateButtons">
    <g:paginate action="list" total="${totalTemplates}"/>
  </div>
</g:if>