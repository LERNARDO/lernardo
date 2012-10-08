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
        <td class="one"><g:message code="groupPartner.profile.service"/>:</td>
        <td class="two">${entity.profile.service}</td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="partners"/>:</td>
        <td class="two">
            <erp:getPartnersOfPartnerGroup entity="${entity}">
                <ul>
                    <g:each in="${partners}" var="partner">
                        <li>${fieldValue(bean: partner, field: 'profile').decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getPartnersOfPartnerGroup>
        </td>
    </tr>
</table>

