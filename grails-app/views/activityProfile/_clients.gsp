<g:if test="${activity.profile.clientEvaluations}">
  <ul>
    <g:each in="${activity.profile.clientEvaluations}" var="clientEvaluation">
      <li>${clientEvaluation.client.profile.fullName} - ${clientEvaluation.evaluation} <erp:isOperator entity="${entity}"><g:remoteLink action="removeClient" update="clients2" id="${activity.id}" params="[clientEvaluation: clientEvaluation.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Betreuten entfernen" align="top"/></g:remoteLink></erp:isOperator></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="clients.notAssigned"/></span>
</g:else>