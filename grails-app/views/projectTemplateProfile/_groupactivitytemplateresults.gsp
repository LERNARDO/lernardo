<g:if test="${results}">
  <div class="remoteresults" style="width:635px">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'projectTemplateProfile', action: 'addGroupActivityTemplate', id: projectUnitTemplate, params: [groupActivityTemplate: entity.id, i: i, projectTemplate: projectTemplate]]" update="groups2-${i}" before="showspinner('#groups2-${i}'); toggle('#groups${i}');" after="${remoteFunction(action: 'updateduration', update: 'updateduration', id: projectTemplate)}">
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