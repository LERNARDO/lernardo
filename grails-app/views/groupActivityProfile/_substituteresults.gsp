<g:if test="${results}">
  <div class="remoteresults" style="width:635px">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller:'groupActivityProfile', action:'addSubstitute', id:group, params:[substitute: entity.id]]" update="substitutes2" before="showspinner('#substitutes2'); toggle('#substitutes');">
      <div class="remoteresult" style="width:300px">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold">${entity.profile.fullName}</span></td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>