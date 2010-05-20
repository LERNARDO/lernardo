<g:if test="${parents}">
  <ul>
    <g:each in="${parents}" var="parent">
      <li><g:link controller="${parent.type.supertype.name +'Profile'}" action="show" id="${parent.id}" params="[entity:parent.id]">${parent.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeParent" update="parents2${j}${i}" id="${unit.id}" params="[parent: parent.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Erziehungsberechtigten entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Erziehungsberechtigten zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>