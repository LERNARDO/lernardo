<ul>
  <g:each in="${evaluations}" status="i" var="evaluation">
    <div class="leistung-item">
      <table cellpadding="2">
        <tr>
          <td class="bold vtop"><g:message code="client"/>:</td>
          <td><g:link controller="clientProfile" action="show" id="${evaluation.owner.id}" params="[entity:evaluation.owner.id]">${evaluation.owner.profile.fullName}</g:link></td>
        </tr>
        <tr>
          <td class="bold vtop"><g:message code="date"/>:</td>
          <td><g:formatDate date="${evaluation.dateCreated}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>
        <tr>
          <td class="bold vtop"><g:message code="description"/>:</td>
          <td>${evaluation.description.decodeHTML()}</td>
        </tr>
        <tr>
          <td class="bold vtop"><g:message code="action"/>:</td>
          <td>${evaluation.method.decodeHTML()}</td>
        </tr>
        <tr>
          <td class="strong vtop"><g:message code="from"/>:</td>
          <td>${evaluation.writer.profile.fullName}</td>
        </tr>
      </table>
      <erp:isMeOrAdminOrOperator entity="${evaluation.writer}" current="${currentEntity}">
        <g:link class="helperButton" action="edit" id="${evaluation.id}" params="[entity:entity.id]">${message(code:'edit')}</g:link>
      </erp:isMeOrAdminOrOperator>
    </div>
  </g:each>
</ul>

<div class="paginateButtons">
  <util:remotePaginate action="showByClient" total="${totalEvaluations}" update="remoteEvaluations" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}" id="${entity.id}" params="[value: value]"/>
</div>