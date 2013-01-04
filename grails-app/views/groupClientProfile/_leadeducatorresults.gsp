<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'groupClientProfile', action: 'addLeadEducator', id: group, params: [leadeducator: entity.id]]" update="leadeducators2" before="showspinner('#leadeducators2');" after="toggle('#leadeducators');">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65" height="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold">${entity.profile}</span><br/><br/>
            ${entity.profile.currentStreet ?: '<div class="italic">'+message(code:'empty')+ '</div>'}
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>