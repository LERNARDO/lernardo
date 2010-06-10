<g:if test="${group.profile.representatives}">
  <g:each in="${group.profile.representatives}" var="representative">
    <div style="border-bottom: 1px solid #eee; margin-bottom: 5px;">
      <ul style="padding-bottom: 5px">
        <li>Name: ${representative.firstName} ${representative.lastName} <app:isOperator entity="${entity}"><g:remoteLink action="removeRepresentative" update="representatives2" id="${group.id}" params="[representative: representative.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Repräsentant entfernen" align="top"/></g:remoteLink></app:isOperator></li>
        <li>Land: ${representative.country}</li>
        <li>PLZ: ${representative.zip}</li>
        <li>Stadt: ${representative.city}</li>
        <li>Straße: ${representative.street}</li>
        <li>Telefon: ${representative.phone}</li>
        <li>E-Mail: ${representative.email}</li>
        <li>Funktion: ${representative.function}</li>
      </ul>
    </div>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Repräsentanten eingetragen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>