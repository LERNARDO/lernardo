<g:if test="${group.profile.representatives}">
  <table>
    <g:each in="${group.profile.representatives}" var="representative">
      <tr class="prop">
        <td valign="top" class="italic" width="100"><g:message code="name"/>:</td><td colspan="6" class="value">${representative.firstName}  ${representative.lastName}</td>
        <td><erp:accessCheck types="['Betreiber']">
          <g:remoteLink action="editRepresentative" update="representatives2" id="${group.id}" params="[representative: representative.id]" before="showspinner('#representatives2')"><img src="${g.resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink>
          <g:remoteLink action="removeRepresentative" update="representatives2" id="${group.id}" params="[representative: representative.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir: 'images/icons', file: 'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
        </erp:accessCheck></td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="representatives.adr"/>:</td><td colspan="6" class="value">${representative.zip} ${representative.city}, ${representative.street}, ${representative.country}</td></tr>
      <tr class="prop">
        <td valign="top" class="italic"><g:message code="phone"/>:</td><td class="value" width="150">${representative.phone ?: '<span class="italic">'+message(code:'none')+ '</span>'}</td>
        <td valign="top" class="italic" width="60"><g:message code="email"/>:</td><td class="value" width="160">${representative.email ?: '<span class="italic">'+message(code:'none')+ '</span>'}</td>
        <td valign="top" class="italic" width="100"><g:message code="representatives.function"/>:</td><td class="value">${representative.function ?: '<span class="italic">'+message(code:'none')+ '</span>'}</td>
      </tr>
      <tr><td colspan="8" style="border: 1px solid; border-color:transparent transparent lightgray; padding:3px;"></td></tr>
    </g:each>
  </table>
</g:if>
<g:else>
  <span class="italic red"><g:message code="representatives.nothing"/></span>
</g:else>