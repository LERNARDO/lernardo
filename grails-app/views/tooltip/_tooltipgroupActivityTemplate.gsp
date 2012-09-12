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
        <td class="one"><g:message code="groupActivityTemplate.profile.realDuration"/></td>
        <td class="two">${fieldValue(bean: entity, field: 'profile.realDuration')} min</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
        <td class="two">${entity?.profile?.ageFrom ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="activityTemplate.ageTo"/></td>
        <td class="two">${entity?.profile?.ageTo ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"># <g:message code="activityTemplates"/></td>
        <td class="two">${entity.profile.templates.size()}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="labels"/></td>
        <td class="two">
            <g:if test="${entity.profile.labels}">
                <ul>
                    <g:each in="${entity.profile.labels}" var="label">
                        <li>${label.name}</li>
                    </g:each>
                </ul>
            </g:if>
            <g:else>
                <span class="italic"><g:message code="labels.empty"/></span>
            </g:else>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="status"/></td>
        <td class="two"><g:message code="status.${entity.profile.status}"/></td>
    </tr>
</table>

