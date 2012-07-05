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
        <td class="one"><g:message code="groupFamily"/>:</td>
        <td class="two">
            <erp:getFamilyOfEntity entity="${entity}">${fieldValue(bean: family, field: 'profile.fullName').decodeHTML()}</erp:getFamilyOfEntity>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="birthDate"/>:</td>
        <td class="two"><g:formatDate date="${entity.profile.birthDate}" format="dd. MM. yyyy"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="groupColony"/>:</td>
        <td class="two">
            <erp:getColonyOfEntity entity="${entity}">${fieldValue(bean: colony, field: 'profile.fullName').decodeHTML()}</erp:getColonyOfEntity>
        </td>
    </tr>
</table>

