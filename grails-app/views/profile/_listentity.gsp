<td>
  %{--<erp:isEnabled entity="${entity}">
    <g:link controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}">${entity.profile}</g:link>
  </erp:isEnabled>
  <erp:notEnabled entity="${entity}">
    <span class="notEnabled">${entity.profile}</span>
  </erp:notEnabled>--}%
  <erp:profileImage entity="${entity}" width="30" height="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
  <g:link class="largetooltip" data-idd="${entity.id}" controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}">${entity.profile.decodeHTML()}</g:link>
</td>
%{--<td class="col">${entity.type.name}</td>  --}%
<td><g:message code="${entity.type.supertype.name}"/></td>
<td id="entity-enabled-${i}"><g:if test="${entity.user}"><g:if test="${entity.user.enabled}"><img src="${resource (dir:'images/icons', file:'icon_tick.png')}" alt="Active" align="top"/></g:if><g:else><img src="${resource (dir:'images/icons', file:'cross.png')}" alt="Inactive" align="top"/></g:else></g:if></td>
<td>
  <g:if test="${entity.user}">
    <g:if test="${entity.user.lastAction}">
      <g:formatDate date="${entity.user.lastAction}" format="dd.MM.yyyy, HH:mm"/>
    </g:if>
    <g:else>
      <span class="italic"><g:message code="never"/></span>
    </g:else>
  </g:if>
</td>
<td id="entity-roles-${i}" style="width: 200px;"><g:if test="${entity.user}"><g:join in="${entity?.user?.authorities?.collect {it.authority}}"/></g:if></td>
<td style="width: 300px;">
  <erp:isSystemAdmin>
    <g:if test="${entity.user}">
      <div class="buttons">
        <erp:hasNotRoles entity="${entity}" roles="['ROLE_ADMIN']">
          <g:remoteLink class="buttonGray" update="listentity-${i}" controller="profile" action="giveAdminRole" id="${entity.id}" params="[i:i]" before="showspinner('#entity-roles-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_noadmin.png')}" alt="Admin geben" align="top"/>--}%<g:message code="profile.list.giveAdmin"/></g:remoteLink>
        </erp:hasNotRoles>

        <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN']">
          <g:remoteLink class="buttonGray" update="listentity-${i}" controller="profile" action="takeAdminRole" id="${entity.id}" params="[i:i]" before="showspinner('#entity-roles-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_anadmin.png')}" alt="Admin nehmen" align="top"/>--}%<g:message code="profile.list.takeAdmin"/></g:remoteLink>
        </erp:accessCheck>
      </div>
    </g:if>
    </erp:isSystemAdmin>
  <erp:notMe entity="${entity}">
    <g:if test="${entity.user}">
      <div class="buttons">
        <erp:isEnabled entity="${entity}">
          <g:remoteLink class="buttonGray" update="listentity-${i}" controller="profile" action="disable" id="${entity.id}" params="[i:i]" before="showspinner('#entity-enabled-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_enabled.png')}" alt="Deaktivieren" align="top"/>--}%<g:message code="profile.list.deactivate"/></g:remoteLink>
        </erp:isEnabled>
        <erp:notEnabled entity="${entity}">
          <g:remoteLink class="buttonGray" update="listentity-${i}" controller="profile" action="enable" id="${entity.id}" params="[i:i]" before="showspinner('#entity-enabled-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_disabled.png')}" alt="Aktivieren" align="top"/>--}%<g:message code="profile.list.activate"/></g:remoteLink>
        </erp:notEnabled>
      </div>
    </g:if>
    <erp:accessCheck roles="['ROLE_ADMIN']">
      <g:if test="${!entity?.user?.authorities*.authority?.contains('ROLE_SYSTEMADMIN')}">
        <g:form controller="${entity.type.supertype.name + 'Profile'}" id="${entity.id}">
          <div class="buttons">
            <g:actionSubmit class="buttonGray" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: entity.id)}" />
          </div>
        </g:form>
      </g:if>
      %{--- <g:link controller="${entity.type.supertype.name + 'Profile'}" action="del" id="${entity.id}" onclick="${erp.getLinks(id: entity.id)}">--}%%{--<img src="${resource (dir:'images/icons', file:'cross.png')}" alt="Löschen" align="top"/>--}%%{--<g:message code="delete"/></g:link>--}%
    </erp:accessCheck>
  </erp:notMe>

</td>
