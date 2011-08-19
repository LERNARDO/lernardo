<td>
  %{--<erp:isEnabled entity="${entity}">
    <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link>
  </erp:isEnabled>
  <erp:notEnabled entity="${entity}">
    <span class="notEnabled">${entity.profile.fullName}</span>
  </erp:notEnabled>--}%
  <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link>
</td>
%{--<td class="col">${entity.type.name}</td>  --}%
<td><g:message code="profiletype.${entity.type.supertype.name}"/></td>
<td id="entity-enabled-${i}"><g:if test="${entity.user}"><g:if test="${entity.user.enabled}"><img src="${resource (dir:'images/icons', file:'icon_tick.png')}" alt="Active" align="top"/></g:if><g:else><img src="${resource (dir:'images/icons', file:'cross.png')}" alt="Inactive" align="top"/></g:else></g:if></td>
<td id="entity-roles-${i}"><g:if test="${entity.user}"><g:join in="${entity?.user?.authorities?.collect {it.authority}}"/></g:if></td>
<td>
  <erp:notMe entity="${entity}">
    <g:if test="${entity.user}">
      <erp:isEnabled entity="${entity}">
        <g:remoteLink update="listentity-${i}" controller="profile" action="disable" id="${entity.id}" params="[i:i]" before="showspinner('#entity-enabled-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_enabled.png')}" alt="Deaktivieren" align="top"/>--}%<g:message code="profile.list.deactivate"/></g:remoteLink>
      </erp:isEnabled>
      <erp:notEnabled entity="${entity}">
        <g:remoteLink update="listentity-${i}" controller="profile" action="enable" id="${entity.id}" params="[i:i]" before="showspinner('#entity-enabled-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_disabled.png')}" alt="Aktivieren" align="top"/>--}%<g:message code="profile.list.activate"/></g:remoteLink>
      </erp:notEnabled>
    </g:if>
    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']">
      <g:if test="${!entity.user?.authorities*.authority.contains('ROLE_SYSTEMADMIN')}">
        <g:form controller="${entity.type.supertype.name + 'Profile'}" id="${entity.id}">
          - <g:actionSubmit  action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: entity.id)}" />
        </g:form>
      </g:if>
      %{--- <g:link controller="${entity.type.supertype.name +'Profile'}" action="del" id="${entity.id}" onclick="${erp.getLinks(id: entity.id)}">--}%%{--<img src="${resource (dir:'images/icons', file:'cross.png')}" alt="Löschen" align="top"/>--}%%{--<g:message code="profile.list.delete"/></g:link>--}%
    </erp:accessCheck>
  </erp:notMe>
  <erp:isSystemAdmin entity="${currentEntity}">
  <g:if test="${entity.user}">
    <erp:hasNotRoles entity="${entity}" roles="['ROLE_ADMIN']">
      - <g:remoteLink update="listentity-${i}" controller="profile" action="giveAdminRole" id="${entity.id}" params="[i:i]" before="showspinner('#entity-roles-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_noadmin.png')}" alt="Admin geben" align="top"/>--}%<g:message code="profile.list.giveAdmin"/></g:remoteLink>
    </erp:hasNotRoles>

    <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN']">
      - <g:remoteLink update="listentity-${i}" controller="profile" action="takeAdminRole" id="${entity.id}" params="[i:i]" before="showspinner('#entity-roles-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_anadmin.png')}" alt="Admin nehmen" align="top"/>--}%<g:message code="profile.list.takeAdmin"/></g:remoteLink>
    </erp:accessCheck>
  </g:if>
  </erp:isSystemAdmin>
</td>
