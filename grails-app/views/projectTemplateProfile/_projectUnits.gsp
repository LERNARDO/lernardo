<g:if test="${projectUnits}">

  <span class="bold">Anzahl Einheiten:</span> ${projectUnits.size()}<br />
  <span class="bold">Errechnete Gesamtdauer:</span> ${calculatedDuration ?: 0} min

  <g:each in="${projectUnits}" var="projectUnit" status="i">
    <div class="element-box">${i+1}. Projekteinheit: ${projectUnit.profile.fullName} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeProjectUnit" update="projectunits2" id="${projectTemplate.id}" params="[projectUnit: projectUnit.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Projekteinheit entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin>

      <p class="bold" style="margin-left: 15px">Aktivitätsblockvorlagen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-groups${i}"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Aktivitätsblockvorlage hinzufügen" /></a></app:isMeOrAdmin></p>
      <jq:jquery>
        <jq:toggle sourceId="show-groups${i}" targetId="groups${i}"/>
      </jq:jquery>
      <div id="groups${i}" style="display:none; margin: 0 0 5px 15px; background: #ccc; padding: 5px">
        <g:formRemote name="formRemote" url="[controller:'projectTemplateProfile', action:'addGroupActivityTemplate', id:projectUnit.id, params:[i: i]]" update="groups2${i}" before="hideform('#groups${i}')">
          Aktivitätsblockvorlagen: <g:select name="groupActivityTemplate" from="${allGroupActivityTemplates}" optionKey="id" optionValue="profile"/>
          %{--<g:select name="parent" from="${allParents}" optionKey="id" optionValue="profile"/>--}%
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>     

      <div id="groups2${i}">
        <app:getGroupActivityTemplates projectUnit="${projectUnit}">
          <g:render template="groupActivityTemplates" model="[groupActivityTemplates: groupActivityTemplates, unit: projectUnit, i: i]"/>          
        </app:getGroupActivityTemplates>
      </div>

    </div>
  </g:each>
  
</g:if>
<g:else>
  <span class="italic">Keine Projekteinheiten hinzugefügt <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>