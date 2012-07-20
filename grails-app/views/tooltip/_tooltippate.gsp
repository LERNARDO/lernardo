<table>
    <tr class="prop">
        <td class="one"><g:message code="type"/>:</td>
        <td class="two"><g:message code="${entity.type.supertype.name}"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="name"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.fullName').decodeHTML()}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="country"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.country') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="pate.profile.gcs"/>:</td>
        <td class="two">
            <erp:getGodchildrenOfPate entity="${entity}">
                <ul>
                    <g:each in="${godchildren}" var="godchild">
                        <li>${fieldValue(bean: godchild, field: 'profile.fullName').decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getGodchildrenOfPate>
        </td>
    </tr>
</table>

