<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller: 'pateProfile', action: 'addGodchildren', id: pate, params: [child: entity.id]]" update="godchildren2" before="showspinner('#godchildren2')">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65" height="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold">${entity.profile}</span><br/><br/>
            %{--${entity.profile.currentZip ?: '<div class="italic">'+message(code:'empty')+ '</div>'} ${entity.profile.currentCity ?: '<div class="italic">'+message(code:'empty')+ '</div>'}<br/>
            ${entity.profile.currentCountry}</td>--}%
            ${entity.profile.currentStreet ?: '<div class="italic">'+message(code:'empty')+ '</div>'}
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>