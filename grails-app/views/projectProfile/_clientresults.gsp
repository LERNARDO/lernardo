<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'projectProfile', action: 'addClient', id: group, params: [client: entity.id]]" update="clients2" before="showspinner('#clients2'); toggle('#clients');">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold">${entity.profile}</span><br/><g:message code="${entity.type.supertype.name}"/></td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>