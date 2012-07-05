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
        <td class="one"><g:message code="street"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.street') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="zip"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.zip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="city"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.city') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="country"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.country') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="leadEducators"/>:</td>
        <td class="two">
            <erp:getLeadEducatorsOfFacility entity="${entity}">
                <ul>
                    <g:each in="${leadEducators}" var="educator">
                        <li>${fieldValue(bean: educator, field: 'profile.fullName').decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getLeadEducatorsOfFacility>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="educators"/>:</td>
        <td class="two">
            <erp:getEducatorsOfFacility entity="${entity}">
                <ul>
                    <g:each in="${educators}" var="educator">
                        <li>${fieldValue(bean: educator, field: 'profile.fullName').decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getEducatorsOfFacility>
        </td>
    </tr>
</table>

