<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller:'clientProfile', action:'addFacility', id: client, params:[facility: entity.id]]" update="facilities2" before="showspinner('#facilities2');" after="toggle('#facilities');">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold">${entity.profile.fullName}</span></tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>