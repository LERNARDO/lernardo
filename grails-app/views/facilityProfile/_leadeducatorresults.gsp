<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller:'facilityProfile', action:'addLeadEducator', id:facility, params:[leadeducator: entity.id]]" update="leadeducators2" before="showspinner('#leadeducators2');" after="toggle('#leadeducators');">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold">${entity.profile.fullName}</span><br/><br/>
            ${entity.profile.currentZip ?: '<div class="italic">'+message(code:'empty')+'</div>'} ${entity.profile.currentCity ?: '<div class="italic">'+message(code:'empty')+'</div>'}<br/>
            ${entity.profile.currentStreet ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            ${entity.profile.currentCountry}</td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>