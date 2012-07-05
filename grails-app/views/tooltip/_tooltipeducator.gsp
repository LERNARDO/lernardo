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
        <td class="one"><g:message code="birthDate"/>:</td>
        <td class="two"><g:formatDate date="${entity.profile.birthDate}" format="dd. MM. yyyy"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="facilities"/>:</td>
        <td class="two">
            <erp:getFacilitiesOfEducator entity="${entity}">
                <ul>
                    <g:each in="${facilities}" var="facility">
                        <li>${facility.profile.fullName.decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getFacilitiesOfEducator>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="educator.profile.employment"/>:</td>
        <td class="two">${entity.profile.employment.decodeHTML() ?: '<div class="italic">' + message(code: "noData") + '</div>'}</td>
    </tr>
</table>

