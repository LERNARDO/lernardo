<g:if test="${godchildren}">
  <ul>
  <g:each in="${godchildren}" var="child">
    <li><g:link controller="${child.type.supertype.name +'Profile'}" action="show" id="${child.id}" params="[entity:child.id]">${child.profile.fullName}</g:link> <app:isOperator entity="${entity}"><g:remoteLink action="removeGodchildren" update="godchildren2" id="${pate.id}" params="[child: child.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Patenkind entfernen" align="top"/></g:remoteLink></app:isOperator></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="pate.profile.gcs_empty"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>