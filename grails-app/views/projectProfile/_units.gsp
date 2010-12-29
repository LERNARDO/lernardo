<g:if test="${units}">
  <div style="border-bottom: 1px solid #eee; padding-left: 15px;">
  <ul>
    <g:each in="${units}" var="unit" status="i">
      <li style="border-bottom: 1px solid #ccc; margin-bottom: 5px">
        ${unit.profile.fullName}, Beginn: <g:formatDate date="${unit.profile.date}" format="HH:mm"/> Uhr, Dauer: ${unit.profile.duration} Minuten <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeUnit" update="units2" id="${projectDay.id}" params="[unit: unit.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Einheit entfernen" align="top"/></g:remoteLink></erp:accessCheck><br/>

        <p class="bold">Aktivitätsvorlagenblöcke</p>
        <erp:getProjectUnitActivityGroups projectUnit="${unit}">
          <ul style="margin-left: 15px">
            <g:each in="${activityGroups}" var="activityGroup">
              <li><g:link controller="groupActivityTemplateProfile" action="show" id="${activityGroup.id}" params="[entity:activityGroup.id]">${activityGroup.profile.fullName}</g:link></li>
            </g:each>
          </ul>
        </erp:getProjectUnitActivityGroups>

        <p class="bold">Erziehungsberechtigte <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#parents${i}'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Erziehungsberechtigten hinzufügen" /></a></erp:accessCheck></p>
        <div id="parents${i}" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addParent', id:unit.id, params:[i: i]]" update="parents2${i}" before="showspinner('#parents2${i}')">
            <table>
              <tr>
                <td style="padding: 5px 10px 0 0;"><g:select name="parent" from="${allParents}" optionKey="id" optionValue="profile"/></td>
                <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
              </tr>
            </table>
          </g:formRemote>
        </div>

        <div id="parents2${i}">
          <erp:getProjectUnitParents projectUnit="${unit}">
            <g:render template="parents" model="[parents: parents, unit: unit, i: i, entity: entity]"/>
          </erp:getProjectUnitParents>
        </div>

        <p class="bold">Partner <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#partners${i}'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Partner hinzufügen" /></a></erp:accessCheck></p>
        <div id="partners${i}" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addPartner', id:unit.id, params:[i: i]]" update="partners2${i}" before="showspinner('#partners2${i}')">
            <table>
              <tr>
                <td style="padding: 5px 10px 0 0;"><g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/></td>
                <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
              </tr>
            </table>
          </g:formRemote>
        </div>

        <div id="partners2${i}">
          <erp:getProjectUnitPartners projectUnit="${unit}">
            <g:render template="partners" model="[partners: partners, unit: unit, i: i, entity: entity]"/>
          </erp:getProjectUnitPartners>
        </div>

      </li>
    </g:each>
  </ul>
  </div>
</g:if>
<g:else>
  <span class="italic red">Bitte die Projekteinheiten auswählen, die an diesem Projekttag stattfinden sollen!%{--Keine Einheiten zugewiesen--}% %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>