<g:if test="${parents}">
  <ul>
  <g:each in="${parents}" var="parent">
    <li><g:link controller="${parent.type.supertype.name +'Profile'}" action="show" id="${parent.id}" params="[entity:parent.id]">${parent.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeParent" update="parents2" id="${group.id}" params="[parent: parent.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false" after="${remoteFunction(action:'updateFamilyCount',update:'familyCount',id:group.id)}"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Erziehungsberechtigten entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="groupFamily.profile.parents.empty"/> <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>