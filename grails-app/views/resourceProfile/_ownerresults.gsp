<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'resourceProfile', action: 'addOwner', id: resourceInstance, params: [entity: entity.id]]" update="owner2" before="showspinner('#owner2'); toggle('#owner');">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65" height="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold">${entity.profile}</span></td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>