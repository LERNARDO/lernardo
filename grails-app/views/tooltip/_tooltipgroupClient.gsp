<table>
    <tr class="prop">
        <td class="one"><g:message code="type"/>:</td>
        <td class="two"><g:message code="${entity.type.supertype.name}"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="name"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile').decodeHTML()}</td>
    </tr>
    <tr class="prop">
        <td class="one"># <g:message code="clients"/>:</td>
        <td class="two"><erp:getClientsCountOfEntity entity="${entity}"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="description"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.description').decodeHTML() ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
    </tr>
</table>