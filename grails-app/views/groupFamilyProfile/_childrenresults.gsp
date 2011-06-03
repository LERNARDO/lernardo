<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller:'groupFamilyProfile', action:'addChild', id:group, params:[child: entity.id]]" update="childs2" before="showspinner('#childs2'); toggle('#childs');" after="${remoteFunction(action:'updateFamilyCount',update:'familyCount',id:group)}">
      <div class="remoteresult">
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