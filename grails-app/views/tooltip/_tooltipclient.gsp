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
        <td class="one"><g:message code="birthDate"/>:</td>
        <td class="two"><g:formatDate date="${entity.profile.birthDate}" format="dd. MM. yyyy"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="groupColony"/>:</td>
        <td class="two">
            <erp:getColonyOfEntity entity="${entity}">${fieldValue(bean: colony, field: 'profile').decodeHTML()}</erp:getColonyOfEntity>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="client.profile.school"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.school').decodeHTML() ?: '<span class="italic">' + message(code: 'client.noSchoolEntered') + '</span>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="groupFamily"/>:</td>
        <td class="two">
            <erp:getFamilyOfEntity entity="${entity}">${fieldValue(bean: family, field: 'profile').decodeHTML()}</erp:getFamilyOfEntity>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="facilities"/>:</td>
        <td class="two">
            <erp:getFacilitiesOfClient entity="${entity}">
                <ul>
                    <g:each in="${facilities}" var="facility">
                        <li>${fieldValue(bean: facility, field: 'profile').decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getFacilitiesOfClient>
        </td>
    </tr>
</table>

