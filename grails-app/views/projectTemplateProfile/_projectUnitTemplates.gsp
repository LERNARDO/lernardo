<g:if test="${projectUnitTemplates}">

  <span class="bold"><g:message code="numberOfProjectUnitTemplates"/>:</span> ${projectUnitTemplates.size()}<br />
  <span id="updateduration"><g:render template="updateduration" model="[calculatedDuration: calculatedDuration, projectTemplate: projectTemplate]"/></span>

  <g:each in="${projectUnitTemplates}" var="projectUnitTemplate" status="i">
    <div class="element-box"><span class="bold">${i+1}. <g:message code="projectUnitTemplate"/>:</span> <span id="projectName${i}">${projectUnitTemplate.profile.fullName}</span> <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" creatorof="${projectTemplate}">
      <g:remoteLink action="editProjectUnitTemplate" update="projectName${i}" id="${projectTemplate.id}" params="[projectUnitTemplate: projectUnitTemplate.id, i: i]"><img src="${g.resource(dir:'images/icons', file:'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink>
      <g:remoteLink action="removeProjectUnitTemplate" update="projectunittemplates2" id="${projectTemplate.id}" params="[projectUnitTemplate: projectUnitTemplate.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
    </erp:accessCheck>

      <p class="bold" style="margin-left: 15px"><g:message code="groupActivityTemplates"/> <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" creatorof="${projectTemplate}"><a onclick="toggle('#groups${i}'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Aktivitätsblockvorlage hinzufügen" /></a></erp:accessCheck></p>
      <div id="groups${i}" style="display:none; margin: 0 0 5px 15px;">

        <g:message code="search"/>:<br/>
        %{--TODO: this uses a custom tag because the official implementation is broken, see: http://jira.codehaus.org/browse/GRAILS-2512--}%
        <erp:remoteField size="40" name="remoteField${i}" update="remoteGroupActivityTemplate${i}" action="remoteGroupActivityTemplate" id="${projectUnitTemplate.id}" params="[i: i, projectTemplate: projectTemplate.id]" before="showspinner('#remoteGroupActivityTemplate')"/>
        <div id="remoteGroupActivityTemplate${i}"></div>

      </div>     

      <div id="groups2-${i}">
        <erp:getGroupActivityTemplates projectUnit="${projectUnitTemplate}">
          <g:render template="groupActivityTemplates" model="[groupActivityTemplates: groupActivityTemplates, unit: projectUnitTemplate, i: i, projectTemplate: projectTemplate]"/>
        </erp:getGroupActivityTemplates>
      </div>

    </div>
  </g:each>
  
</g:if>
<g:else>
  <span class="italic red"><g:message code="projectUnits.notAssigned"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>