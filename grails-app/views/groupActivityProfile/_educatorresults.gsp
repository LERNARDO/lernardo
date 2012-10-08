<g:if test="${results}">
  <div class="remoteresults" style="width:635px">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'groupActivityProfile', action: 'addEducator', id: group, params: [educator: entity.id]]" update="educators2" before="showspinner('#educators2'); toggle('#educators');">
      <div class="remoteresult" style="width:300px">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold">${entity.profile}</span></td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>