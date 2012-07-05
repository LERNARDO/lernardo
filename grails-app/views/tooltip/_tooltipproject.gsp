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
        <td class="one"><g:message code="begin"/></td>
        <td class="two"><g:formatDate date="${entity.profile.startDate}" format="dd. MM. yyyy"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="end"/></td>
        <td class="two"><g:formatDate date="${entity.profile.endDate}" format="dd. MM. yyyy"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="facilities"/>:</td>
        <td class="two">
            <erp:getFacilitiesOfProject entity="${entity}">
                <ul>
                    <g:each in="${facilities}" var="facility">
                        <li>${fieldValue(bean: facility, field: 'profile.fullName').decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getFacilitiesOfProject>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"># <g:message code="clients"/></td>
        <td class="two"><erp:getClientsCountOfEntity entity="${entity}"/></td>
    </tr>
    <tr class="prop">
        <td class="one"># <g:message code="projectDays"/></td>
        <td class="two"><erp:getProjectDayCountOfProject entity="${entity}"/></td>
    </tr>
</table>

