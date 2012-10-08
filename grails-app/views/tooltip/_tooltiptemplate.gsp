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
        <td class="one"><g:message code="activityTemplate.goal"/></td>
        <td class="two">${entity?.profile?.goal?.decodeHTML() ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="duration"/></td>
        <td class="two">${entity.profile.duration} <g:message code="minutes"/></td>
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
        <td class="one"><g:message code="activityTemplate.socialForm"/></td>
        <td class="two"><g:message code="socialForm.${entity.profile.socialForm}"/></td>
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