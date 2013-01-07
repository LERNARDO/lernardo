<g:if test="${projectUnitTemplates}">

  <span class="bold"><g:message code="numberOfProjectUnitTemplates"/>:</span> ${projectUnitTemplates.size()}<br />
  <span id="updateduration"><g:render template="updateduration" model="[calculatedDuration: calculatedDuration, projectTemplate: projectTemplate]"/></span>

  <g:each in="${projectUnitTemplates}" var="projectUnitTemplate" status="i">
    <div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
      <span class="bold">${i+1}. <g:message code="projectUnitTemplate"/>:</span> <span id="projectName${i}">${projectUnitTemplate.profile}</span> <erp:accessCheck types="['Betreiber','Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true">
        <g:remoteLink action="editProjectUnitTemplate" update="projectName${i}" id="${projectTemplate.id}" params="[projectUnitTemplate: projectUnitTemplate.id, i: i]"><img src="${g.resource(dir:'images/icons', file:'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink>
        <g:remoteLink action="removeProjectUnitTemplate" update="projectunittemplates2" id="${projectTemplate.id}" params="[projectUnitTemplate: projectUnitTemplate.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
        <g:remoteLink action="moveUp" update="projectunittemplates2" id="${projectUnitTemplate.id}" params="[projectTemplate: projectTemplate.id]"><img src="${g.resource(dir: 'images/icons', file: 'arrow_up.png')}" alt="${message(code:'up')}" align="top"/></g:remoteLink>
        <g:remoteLink action="moveDown" update="projectunittemplates2" id="${projectUnitTemplate.id}" params="[projectTemplate: projectTemplate.id]"><img src="${g.resource(dir: 'images/icons', file: 'arrow_down.png')}" alt="${message(code:'down')}" align="top"/></g:remoteLink>
      </erp:accessCheck>

      %{--activity templates--}%
        <p class="bold" style="margin-left: 15px"><g:message code="activityTemplates"/> <erp:accessCheck types="['Betreiber']" creatorof="${projectTemplate}"><img onclick="toggle('#activities${i}');" src="${g.resource(dir:'images/icons', file:'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></p>
        <div id="activities${i}" style="display: none; margin: 0 0 5px 15px;">

            <g:message code="search"/>:<br/>
            <erp:remoteField size="40" name="remoteField${i}" update="remoteActivityTemplate${i}" action="remoteActivityTemplate" id="${projectUnitTemplate.id}" params="[i: i, projectTemplate: projectTemplate.id]" before="showspinner('#remoteActivityTemplate${i}')"/><br/>

            <g:message code="labels"/>:<br/>
            <g:formRemote name="bla" url="[action: 'remoteActivityTemplateByLabel', id: projectUnitTemplate.id, params: [i: i, projectTemplate: projectTemplate.id]]" update="remoteActivityTemplate${i}">
                <g:select from="${allLabels}" multiple="true" name="labels" value="" style="min-height: 115px;"/>
                <g:submitButton name="bla" value="OK"/>
            </g:formRemote>

            <div id="remoteActivityTemplate${i}"></div>

        </div>

        <div id="activities2-${i}">
            <erp:getActivityTemplates projectUnit="${projectUnitTemplate}">
                <g:render template="activityTemplates" model="[activityTemplates: activityTemplates, unit: projectUnitTemplate, i: i, projectTemplate: projectTemplate]"/>
            </erp:getActivityTemplates>
        </div>

    </div>
  </g:each>
  
</g:if>
<g:else>
  <span class="italic red"><g:message code="projectUnits.notAssigned"/></span>
</g:else>