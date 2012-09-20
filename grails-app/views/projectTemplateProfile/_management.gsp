<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="projectUnitTemplates"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><g:remoteLink action="addProjectUnitTemplate" update="projectunittemplates2" id="${projectTemplate.id}" before="showspinner('#projectunittemplates2')"><img src="${g.resource(dir: 'images/icons', file: 'icon_add_old.png')}" alt="${message(code: 'add')}"/></g:remoteLink></erp:accessCheck></h5>
    <div class="zusatz-show" id="projectunittemplates2">
        <g:render template="projectUnitTemplates" model="[projectUnitTemplates: projectUnitTemplates, projectTemplate: projectTemplate, allLabels: allLabels]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="resources.required"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="resources" style="display:none">

        <g:formRemote name="formRemote" url="[controller: 'resourceProfile', action: 'addResource', id: projectTemplate.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
            <table>
                <tr>
                    <td><g:message code="name"/>:</td>
                    <td><g:textField id="resourceName" size="30" name="name" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="description"/>:</td>
                    <td><g:textArea id="resourceDescription" rows="5" cols="50" name="description" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="resource.profile.amount"/>:</td>
                    <td><g:textField size="5" name="amount" value="1"/></td>
                </tr>
            </table>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
        </g:formRemote>

    </div>
    <div class="zusatz-show" id="resources2">
        <g:render template="/requiredResources/resources" model="[template: projectTemplate]"/>
    </div>
    <div id="templateresources">
        <g:render template="templateresources" model="[templateResources: templateResources, groupActivityTemplateResources: groupActivityTemplateResources, projectTemplate: projectTemplate]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="template.plannedProjects"/> (${instances.size}) <a onclick="toggle('#instances'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="Instanzen"/></a></h5>
    <div class="zusatz-add" id="instances" style="display:none">
        <g:if test="${instances.size() > 0}">
            <ul>
            <g:each in="${instances}" var="instance">
                <li style="list-style-type: disc"><g:link controller="projectProfile" action="show" id="${instance.id}">${instance.profile.fullName}</g:link></li>
            </g:each>
        </g:if>
        <g:else>
        <g:message code="template.notPlannedYet"/>
        </g:else>
    </div>
</div>