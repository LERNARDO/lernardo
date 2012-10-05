<div class="info-msg">
  <g:message code="object.found" args="[projects.size(), message(code: 'projects')]"/>
</div>

<g:if test="${projects}">
  <table class="default-table">
    <thead>
    <tr>
      <th><g:message code="name"/></th>
      <th><g:message code="begin"/></th>
      <th><g:message code="end"/></th>
      <th><g:message code="facility"/></th>
      <th><g:message code="creator"/></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${projects}" status="i" var="project">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td><erp:accessCheck roles="['ROLE_ADMIN']"><g:link action="del" id="${project.id}" onclick="${erp.getLinks(id: project.id)}"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code:'delete')}" style="vertical-align: bottom;"/></g:link></erp:accessCheck> <g:link action="show" id="${project.id}">${fieldValue(bean: project, field: 'profile').decodeHTML()}</g:link></td>
        <td><g:formatDate date="${project.profile.startDate}" format="dd. MM. yyyy"/></td>
        <td><g:formatDate date="${project.profile.endDate}" format="dd. MM. yyyy" /></td>
        <td>
          <erp:getFacilityOfProject entity="${project}">
            <g:link controller="facilityProfile" action="show" id="${facility.id}">${facility.profile.decodeHTML()}</g:link>
          </erp:getFacilityOfProject>
        </td>
        <td><erp:createdBy entity="${project}">${creator?.profile?.decodeHTML()}</erp:createdBy></td>
      </tr>
    </g:each>
    </tbody>
  </table>

</g:if>
