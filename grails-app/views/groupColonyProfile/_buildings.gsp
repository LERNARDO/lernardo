<g:if test="${group.profile.buildings}">
  <table>
    <g:each in="${group.profile.buildings}" var="building">
      <tr class="prop">
        <td valign="top" class="italic" width="100"><g:message code="building.name"/>:</td><td colspan="6" class="value">${building.name}</td>
        <td><app:isOperator entity="${entity}"><g:remoteLink action="removeBuilding" update="buildings2" id="${group.id}" params="[building: building.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir: 'images/icons', file: 'icon_remove.png')}" alt="Gebäude entfernen" align="top"/></g:remoteLink></app:isOperator></td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="building.adr"/>:</td><td colspan="6" class="value">${building.zip} ${building.city}, ${building.street}</td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="building.phone"/>:</td><td class="value" width="150">${building.phone}</td>
        <td valign="top" class="italic" width="60"><g:message code="building.email"/>:</td><td class="value" width="160">${building.email}</td>
        <td valign="top" class="italic" width="100"><g:message code="building.authority"/>:</td><td class="value">${building.authority}</td>
      </tr>
      <tr><td colspan="8" style="border-width:1px; border-color:transparent transparent lightgray; border-style:solid; padding:3px;"></td></tr>
    </g:each>
  </table>
</g:if>
<g:else>
  <span class="italic"><g:message code="building.nothing"/> <img src="${g.resource(dir: 'images/icons', file: 'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>