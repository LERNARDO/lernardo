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
        <td class="one"><g:message code="template"/>:</td>
        <td class="two"><erp:getTemplateOfGroupActivity entity="${entity}">${fieldValue(bean: template, field: 'profile').decodeHTML()}</erp:getTemplateOfGroupActivity></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="date"/>:</td>
        <td class="two"><g:formatDate date="${entity?.profile?.date}" format="dd. MMMM yyyy, HH:mm"
                                      timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="facility"/>:</td>
        <td class="two"><erp:getFacilityOfGroupActivity entity="${entity}">${fieldValue(bean: facility, field: 'profile').decodeHTML()}</erp:getFacilityOfGroupActivity></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="educators"/>:</td>
        <td class="two">
            <erp:getEducatorsOfGroupActivity entity="${entity}">
                <ul>
                    <g:each in="${educators}" var="educator">
                        <li>${fieldValue(bean: educator, field: 'profile').decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getEducatorsOfGroupActivity>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"># <g:message code="clients"/>:</td>
        <td class="two"><erp:getClientsCountOfEntity entity="${entity}"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="description"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
    </tr>
</table>