<g:if test="${results}">
  <div class="remoteresults" style="width:635px">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'projectTemplateProfile', action: 'addActivityTemplate', id: projectUnitTemplate, params: [activityTemplate: entity.id, i: i, projectTemplate: projectTemplate]]" update="activities2-${i}" before="showspinner('#activities2-${i}'); toggle('#activities${i}');">
      <div class="remoteresult" style="width:300px">
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