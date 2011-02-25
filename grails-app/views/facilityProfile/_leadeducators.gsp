<g:if test="${leadeducators}">
  <ul>
    <g:each in="${leadeducators}" var="educator">
      <li><g:link controller="${educator.type.supertype.name +'Profile'}" action="show" id="${educator.id}" params="[entity:educator.id]">${educator.profile.fullName}</g:link> <erp:isOperator entity="${entity}"><g:remoteLink action="removeLeadEducator" update="leadeducators2" id="${facility.id}" params="[leadeducator: educator.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Leitenden Pädagogen entfernen" align="top"/></g:remoteLink></erp:isOperator></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="leadEducators.empty"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>