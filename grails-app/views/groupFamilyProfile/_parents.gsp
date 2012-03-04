<g:if test="${parents}">
  <ul>
  <g:each in="${parents}" var="parent">
    <li><g:link controller="${parent.type.supertype.name +'Profile'}" action="show" id="${parent.id}">${parent.profile.fullName.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']"><g:remoteLink action="removeParent" update="parents2" id="${group.id}" params="[parent: parent.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false" after="${remoteFunction(action:'updateFamilyCount',update:'familyCount',id:group.id)}"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="groupFamily.profile.parents.empty"/></span>
</g:else>