<g:if test="${client.profile.contacts}">
  <table>
    <g:each in="${client.profile.contacts}" var="representative">
      <tr class="prop">
        <td valign="top" class="italic" width="100"><g:message code="name"/>:</td><td colspan="6" class="value">${representative.firstName}  ${representative.lastName}</td>
        <td><erp:accessCheck entity="${entity}" types="['Betreiber']">
          <g:remoteLink action="editContact" update="contacts2" id="${client.id}" params="[contact: representative.id]" before="showspinner('#contacts2')"><img src="${g.resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink>
          <g:remoteLink action="removeContact" update="contacts2" id="${client.id}" params="[contact: representative.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir: 'images/icons', file: 'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
        </erp:accessCheck></td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="representatives.adr"/>:</td><td colspan="6" class="value">${representative.zip} ${representative.city}, ${representative.street}</td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="phone"/>:</td><td class="value" width="150">${representative.phone ?: '<div class="italic">'+message(code:'none')+'</div>'}</td>
        <td valign="top" class="italic" width="60"><g:message code="email"/>:</td><td class="value" width="160">${representative.email ?: '<div class="italic">'+message(code:'none')+'</div>'}</td>
        <td valign="top" class="italic" width="100"><g:message code="representatives.function"/>:</td><td class="value">${representative.function ?: '<div class="italic">'+message(code:'none')+'</div>'}</td>
      </tr>
      <tr><td colspan="8" style="border-width:1px; border-color:transparent transparent lightgray; border-style:solid; padding:3px;"></td></tr>
    </g:each>
  </table>
</g:if>
<g:else>
  <span class="italic red"><g:message code="contacts.empty"/></span>
</g:else>