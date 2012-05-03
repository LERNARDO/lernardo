<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'facilityProfile', action: 'addClients', id: facility, params: [clientgroup: entity.id]]" update="clients2" before="showspinner('#clients2');" after="toggle('#clients');">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold">${entity.profile.fullName}</span><br/><br/>
            <g:if test="${entity.type.supertype.name == 'groupClient'}"><g:message code="facility.client.quantity"/>: <erp:getGroupClientsCount entity="${entity}"/></g:if></td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>