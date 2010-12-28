
            <td>
              %{--<app:isEnabled entity="${entity}">
                <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link>
              </app:isEnabled>
              <app:notEnabled entity="${entity}">
                <span class="notEnabled">${entity.profile.fullName}</span>
              </app:notEnabled>--}%
              <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link>
            </td>
            %{--<td class="col">${entity.type.name}</td>  --}%
            <td class="col"><app:getProfileTypeName name="${entity.type.name}"/></td>
            <td class="col" id="entity-enabled-${i}"><g:if test="${entity.user}"><g:if test="${entity.user.enabled}"><img src="${resource (dir:'images/icons', file:'icon_tick.png')}" alt="Active" align="top"/></g:if><g:else><img src="${resource (dir:'images/icons', file:'cross.png')}" alt="Inactive" align="top"/></g:else></g:if></td>
            <td class="col" id="entity-roles-${i}"><g:if test="${entity.user}"><g:join in="${entity?.user?.authorities?.collect {it.authority}}"/></g:if></td>
            <td class="col" style="width: 100px">
              <app:notMe entity="${entity}">
                <g:if test="${entity.user}">
                  <app:isEnabled entity="${entity}">
                    <g:remoteLink update="listentity-${i}" controller="profile" action="disable" id="${entity.id}" params="[i:i]" before="showspinner('#entity-enabled-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_enabled.png')}" alt="Deaktivieren" align="top"/>--}%<g:message code="profile.list.deactivate"/></g:remoteLink>
                  </app:isEnabled>
                  <app:notEnabled entity="${entity}">
                    <g:remoteLink update="listentity-${i}" controller="profile" action="enable" id="${entity.id}" params="[i:i]" before="showspinner('#entity-enabled-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_disabled.png')}" alt="Aktivieren" align="top"/>--}%<g:message code="profile.list.activate"/></g:remoteLink>
                  </app:notEnabled>
                </g:if>
                <app:isAdmin>
                  - <g:link controller="${entity.type.supertype.name +'Profile'}" action="del" id="${entity.id}" onclick="${app.getLinks(id: entity.id)}">%{--<img src="${resource (dir:'images/icons', file:'cross.png')}" alt="Löschen" align="top"/>--}%<g:message code="profile.list.delete"/></g:link>
                </app:isAdmin>
              </app:notMe>
              <app:isSysAdmin entity="${currentEntity}">
              <g:if test="${entity.user}">
                <app:hasNotRoles entity="${entity}" roles="['ROLE_ADMIN']">
                  - <g:remoteLink update="listentity-${i}" controller="profile" action="giveAdminRole" id="${entity.id}" params="[i:i]" before="showspinner('#entity-roles-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_noadmin.png')}" alt="Admin geben" align="top"/>--}%<g:message code="profile.list.giveAdmin"/></g:remoteLink>
                </app:hasNotRoles>

                <app:hasRoles entity="${entity}" roles="['ROLE_ADMIN']">
                  - <g:remoteLink update="listentity-${i}" controller="profile" action="takeAdminRole" id="${entity.id}" params="[i:i]" before="showspinner('#entity-roles-${i}')">%{--<img src="${resource (dir:'images/icons', file:'icon_anadmin.png')}" alt="Admin nehmen" align="top"/>--}%<g:message code="profile.list.takeAdmin"/></g:remoteLink>
                </app:hasRoles>
              </g:if>
              </app:isSysAdmin>
            </td>
