<g:if test="${projectUnitTemplates}">

  <span class="bold">Anzahl Einheiten:</span> ${projectUnitTemplates.size()}<br />
  <span id="updateduration"><g:render template="updateduration" model="[calculatedDuration: calculatedDuration, projectTemplate: projectTemplate]"/></span>

  <g:each in="${projectUnitTemplates}" var="projectUnitTemplate" status="i">
    <div class="element-box"><span class="bold">${i+1}. Projekteinheitvorlage:</span> <span id="projectName${i}">${projectUnitTemplate.profile.fullName}</span> <app:isMeOrAdmin entity="${entity}">
      <g:remoteLink action="editProjectUnitTemplate" update="projectName${i}" id="${projectTemplate.id}" params="[projectUnitTemplate: projectUnitTemplate.id, i: i]"><img src="${g.resource(dir:'images/icons', file:'icon_edit.png')}" alt="Projekteinheitvorlage bearbeiten" align="top"/></g:remoteLink>
      <g:remoteLink action="removeProjectUnitTemplate" update="projectunittemplates2" id="${projectTemplate.id}" params="[projectUnitTemplate: projectUnitTemplate.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Projekteinheitvorlage entfernen" align="top"/></g:remoteLink>
    </app:isMeOrAdmin>

      <p class="bold" style="margin-left: 15px">Aktivitätsblockvorlagen <app:isMeOrAdmin entity="${entity}"><a onclick="toggle('#groups${i}'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Aktivitätsblockvorlage hinzufügen" /></a></app:isMeOrAdmin></p>
      <div id="groups${i}" style="display:none; margin: 0 0 5px 15px;">

        <g:message code="search"/>:<br/>
        %{--TODO: this uses a custom tag because the official implementation is broken, see: http://jira.codehaus.org/browse/GRAILS-2512--}%
        <app:remoteField size="40" name="remoteField${i}" update="remoteGroupActivityTemplate${i}" action="remoteGroupActivityTemplate" id="${projectUnitTemplate.id}" params="[i: i, projectTemplate: projectTemplate.id]" before="showspinner('#remoteGroupActivityTemplate')"/>
        <div id="remoteGroupActivityTemplate${i}"></div>

      </div>     

      <div id="groups2-${i}">
        <app:getGroupActivityTemplates projectUnit="${projectUnitTemplate}">
          <g:render template="groupActivityTemplates" model="[groupActivityTemplates: groupActivityTemplates, unit: projectUnitTemplate, i: i, projectTemplate: projectTemplate]"/>
        </app:getGroupActivityTemplates>
      </div>

    </div>
  </g:each>
  
</g:if>
<g:else>
  <span class="italic red">Keine Projekteinheitenvorlagen hinzugefügt! %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>