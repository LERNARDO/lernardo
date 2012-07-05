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
        <td class="one"><g:message code="representatives"/>:</td>
        <td class="two">
            <g:if test="${entity.profile.representatives}">
                <ul>
                    <g:each in="${entity.profile.representatives}" var="representative">
                        <li>${representative.firstName} ${representative.lastName}</li>
                    </g:each>
                </ul>
            </g:if>
            <g:else>
                <span class="italic"><g:message code="representatives.nothing"/></span>
            </g:else>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="facilities"/>:</td>
        <td class="two">
            <erp:getFacilitiesOfColony entity="${entity}">
                <ul>
                    <g:each in="${facilities}" var="facility">
                        <li>${facility.profile.fullName.decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getFacilitiesOfColony>
        </td>
    </tr>
    <tr class="prop">
        <td class="one"><g:message code="resources"/>:</td>
        <td class="two">
            <erp:getResourcesOfColony entity="${entity}">
                <ul>
                    <g:each in="${resources}" var="resource">
                        <li>${resource.profile.fullName.decodeHTML()}</li>
                    </g:each>
                </ul>
            </erp:getResourcesOfColony>
        </td>
    </tr>
</table>