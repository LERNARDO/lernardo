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
        <td class="one"><g:message code="begin"/>:</td>
        <td class="two"><g:formatDate date="${entity.profile.startDate}" format="dd. MMMM yyyy"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="end"/>:</td>
        <td class="two"><g:formatDate date="${entity.profile.endDate}" format="dd. MMMM yyyy"/></td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="description"/>:</td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.description').decodeHTML() ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="projects"/>:</td>
        <td class="two">
            <erp:getProjectsOfTheme entity="${entity}">
                <ul>
                    <g:each in="${projects}" var="project">
                        <li>${project.profile.decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getProjectsOfTheme>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="groupActivities"/>:</td>
        <td class="two">
            <erp:getActivityGroupsOfTheme entity="${entity}">
                <ul>
                    <g:each in="${activitygroups}" var="group">
                        <li>${group.profile.decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getActivityGroupsOfTheme>
        </td>
    </tr>
</table>

