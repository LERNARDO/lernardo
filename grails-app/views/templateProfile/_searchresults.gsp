<div class="info-msg">
  <g:message code="object.found" args="[totalTemplates, message(code: 'activityTemplates')]"/>
</div>

<table class="default-table">
  <thead>
  <tr>
    <util:remoteSortableColumn property="fullName" title="${message(code:'name')}" action="updateselect" update="templateselect" params="[method1: method1,
                                              method2: method2, method3: method3, method1lower: method1lower,
                                              method1upper: method1upper, method2lower: method2lower,
                                              method2upper: method2upper, method3lower: method3lower,
                                              method3upper: method3upper, name: name,
                                              duration1: duration1, duration2: duration2,
                                              ageFrom: ageFrom, ageTo: ageTo]"/>
    <util:remoteSortableColumn property="duration" title="${message(code:'duration')} (min)" action="updateselect" update="templateselect" params="[method1: method1,
                                              method2: method2, method3: method3, method1lower: method1lower,
                                              method1upper: method1upper, method2lower: method2lower,
                                              method2upper: method2upper, method3lower: method3lower,
                                              method3upper: method3upper, name: name,
                                              duration1: duration1, duration2: duration2,
                                              ageFrom: ageFrom, ageTo: ageTo]"/>
    <util:remoteSortableColumn property="socialForm" title="${message(code:'activityTemplate.socialForm')}" action="updateselect" update="templateselect" params="[method1: method1,
                                              method2: method2, method3: method3, method1lower: method1lower,
                                              method1upper: method1upper, method2lower: method2lower,
                                              method2upper: method2upper, method3lower: method3lower,
                                              method3upper: method3upper, name: name,
                                              duration1: duration1, duration2: duration2,
                                              ageFrom: ageFrom, ageTo: ageTo]"/>
    <th><g:message code="comments"/></th>
    <th><g:message code="creator"/></th>
  </tr>
  </thead>

  <tbody>
  <g:each status="i" in="${allTemplates}" var="templateInstance">
    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
      <td><g:link action="show" id="${templateInstance.id}">${templateInstance.profile.fullName.decodeHTML()}</g:link></td>
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