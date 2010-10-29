<g:if test="${activity.profile.clientEvaluations}">
  <ul>
  <g:each in="${activity.profile.clientEvaluations}" var="clientEvaluation">
    <li>${clientEvaluation.client.profile.fullName} - ${clientEvaluation.evaluation} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeClient" update="clients2" id="${activity.id}" params="[clientEvaluation: clientEvaluation.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Betreuten entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Keine Betreuten eingetragen!</span>
</g:else>