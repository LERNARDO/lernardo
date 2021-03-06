<g:if test="${group.profile.buildings}">
  <table>
    <g:each in="${group.profile.buildings}" var="building">
      <tr class="prop">
        <td valign="top" class="italic" width="100"><g:message code="name"/>:</td><td colspan="6" class="value">${building.name}</td>
        <td><erp:accessCheck types="['Betreiber']"><g:remoteLink action="removeBuilding" update="buildings2" id="${group.id}" params="[building: building.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir: 'images/icons', file: 'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="building.adr"/>:</td><td colspan="6" class="value">${building.zip} ${building.city}, ${building.street}</td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="phone"/>:</td><td class="value" width="150">${building.phone}</td>
        <td valign="top" class="italic" width="60"><g:message code="email"/>:</td><td class="value" width="160">${building.email}</td>
        <td valign="top" class="italic" width="100"><g:message code="building.authority"/>:</td><td class="value">${building.authority}</td>
      </tr>
      <tr><td colspan="8" style="border: 1px solid; border-color:transparent transparent lightgray; padding:3px;"></td></tr>
    </g:each>
  </table>
</g:if>
<g:else>
  <span class="italic red"><g:message code="building.nothing"/></span>
</g:else>