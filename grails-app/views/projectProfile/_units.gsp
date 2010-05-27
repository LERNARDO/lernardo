<g:if test="${units}">
  <ul>
    <g:each in="${units}" var="unit" status="i">
      <li>
        ${unit.profile.fullName} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeUnit" update="units2${j}" id="${projectDay.id}" params="[unit: unit.id, j: j]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Einheit entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin><br/>

        <p class="bold">Aktivitätsvorlagengruppen</p>
        <app:getProjectUnitActivityGroups projectUnit="${unit}">
          <ul>
            <g:each in="${activityGroups}" var="activityGroup">
              <li><g:link controller="groupActivityTemplateProfile" action="show" id="${activityGroup.id}" params="[entity:activityGroup.id]">${activityGroup.profile.fullName}</g:link></li>
            </g:each>
          </ul>
        </app:getProjectUnitActivityGroups>

        <p class="bold">Erziehungsberechtigte <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-parents${j}${i}"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Erziehungsberechtigten hinzufügen" /></a></app:isMeOrAdmin></p>
        <jq:jquery>
          <jq:toggle sourceId="show-parents${j}${i}" targetId="parents${j}${i}"/>
        </jq:jquery>
        <div id="parents${j}${i}" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addParent', id:unit.id, params:[i: i, j: j]]" update="parents2${j}${i}" before="hideform('#parents${j}${i}')">
            <g:select name="parent" from="${allParents}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>

        <div id="parents2${j}${i}">
          <app:getProjectUnitParents projectUnit="${unit}">
            <g:render template="parents" model="[parents: parents, unit: unit, i: i, j: j]"/>
          </app:getProjectUnitParents>
        </div>

        <p class="bold">Partner <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-partners${j}${i}"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Partner hinzufügen" /></a></app:isMeOrAdmin></p>
        <jq:jquery>
          <jq:toggle sourceId="show-partners${j}${i}" targetId="partners${j}${i}"/>
        </jq:jquery>
        <div id="partners${j}${i}" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addPartner', id:unit.id, params:[i: i, j: j]]" update="partners2${j}${i}" before="hideform('#partners${j}${i}')">
            <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>

        <div id="partners2${j}${i}">
          <app:getProjectUnitPartners projectUnit="${unit}">
            <g:render template="parents" model="[partners: partners, unit: unit, i: i, j: j]"/>
          </app:getProjectUnitPartners>
        </div>

      </li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Einheiten zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>