<g:if test="${group.profile.representatives}">
  <table>
    <g:each in="${group.profile.representatives}" var="representative">
      <tr class="prop">
        <td valign="top" class="italic" width="100"><g:message code="representantives.name"/>:</td><td colspan="6" class="value">${representative.firstName}  ${representative.lastName}</td>
        <td><erp:accessCheck entity="${entity}" types="['Betreiber']">
          <g:remoteLink action="editRepresentative" update="representatives2" id="${group.id}" params="[representative: representative.id]" before="showspinner('#representatives2')"><img src="${g.resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink>
          <g:remoteLink action="removeRepresentative" update="representatives2" id="${group.id}" params="[representative: representative.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir: 'images/icons', file: 'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
        </erp:accessCheck></td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="representantives.adr"/>:</td><td colspan="6" class="value">${representative.zip} ${representative.city}, ${representative.street}, ${representative.country}</td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="representantives.phone"/>:</td><td class="value" width="150">${representative.phone ?: '<span class="italic">'+message(code:'none')+'</span>'}</td>
        <td valign="top" class="italic" width="60"><g:message code="representantives.email"/>:</td><td class="value" width="160">${representative.email ?: '<span class="italic">'+message(code:'none')+'</span>'}</td>
        <td valign="top" class="italic" width="100"><g:message code="representantives.function"/>:</td><td class="value">${representative.function ?: '<span class="italic">'+message(code:'none')+'</span>'}</td>
      </tr>
      <tr><td colspan="8" style="border-width:1px; border-color:transparent transparent lightgray; border-style:solid; padding:3px;"></td></tr>
    </g:each>
  </table>
</g:if>
<g:else>
  <span class="italic red"><g:message code="representantives.nothing"/> %{--<img src="${g.resource(dir: 'images/icons', file: 'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>