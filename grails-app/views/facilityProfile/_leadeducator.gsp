<g:if test="${leadeducator}">
  <ul>
    <li><g:link controller="${leadeducator.type.supertype.name +'Profile'}" action="show" id="${leadeducator.id}" params="[entity:leadeducator.id]">${leadeducator.profile.fullName}</g:link> <app:isOperator entity="${entity}"><g:remoteLink action="removeLeadEducator" update="leadeducator2" id="${facility.id}" params="[leadeducator: leadeducator.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Pädagogen entfernen" align="top"/></g:remoteLink></app:isOperator></li>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="leadEducator.empty"/> <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>