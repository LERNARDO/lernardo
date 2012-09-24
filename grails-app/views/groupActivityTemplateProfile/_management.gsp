<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="labels"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${group}" checkstatus="${group}" checkoperator="true"><img onclick="toggle('#labels');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="labels" style="display:none">
        <g:formRemote name="formRemote2" url="[controller: 'groupActivityTemplateProfile', action: 'addLabel', id: group.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
            <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="labels2">
        <g:render template="labels" model="[group: group]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="activityTemplates"/> <erp:accessCheck types="['Betreiber','Pädagoge']" creatorof="${group}" checkstatus="${group}" checkoperator="true"><img onclick="toggle('#templates');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="templates" style="display:none">
        <p><g:message code="activityTemplate.list.hint2"/></p>
        <g:formRemote name="formRemote0" url="[controller: 'groupActivityTemplateProfile', action: 'updateselect']" update="templateselect" before="showspinner('#templateselect');">

            <table>
                <tr>
                    <td><g:message code="name"/>:</td>
                    <td><g:textField name="name" size="30"/></td>
                </tr>
                <tr>
                    <td><g:message code="duration"/>:</td>
                    <td><g:select from="${1..239}" name="duration1" noSelection="['all':message(code:'any')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'secondselect', update: 'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
                        <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> (min)</td>
                </tr>
                <tr>
                    <td><g:message code="labels"/>:</td>
                    <td><g:select from="${allLabels}" multiple="true" name="labels" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="age"/>:</td>
                    <td><g:message code="from"/>: <g:textField name="ageFrom" size="5"/> <g:message code="to"/>: <g:textField name="ageTo" size="5"/></td>
                </tr>
                <tr>
                    <td style="vertical-align: top"><g:message code="vMethod"/> 1:</td>
                    <td>
                        <g:select name="method1" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'listMethods', update: 'elements1', params:'\'id=\' + this.value+\'&dropdown=\'+1')}"/>
                        <div id="elements1"></div>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top"><g:message code="vMethod"/> 2:</td>
                    <td>
                        <g:select name="method2" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'listMethods', update: 'elements2', params:'\'id=\' + this.value+\'&dropdown=\'+2')}"/>
                        <div id="elements2"></div>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top"><g:message code="vMethod"/> 3:</td>
                    <td>
                        <g:select name="method3" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller: 'groupActivityTemplateProfile', action: 'listMethods', update: 'elements3', params:'\'id=\' + this.value+\'&dropdown=\'+3')}"/>
                        <div id="elements3"></div>
                    </td>
                </tr>
            </table>

            <g:submitButton name="button" value="${message(code:'define')}"/>
        </g:formRemote>

        <g:formRemote name="formRemote" url="[controller: 'groupActivityTemplateProfile', action: 'addTemplate', id: group.id]" update="templates2" before="showspinner('#templates2');" after="toggle('#templates');">
            <div id="templateselect" style="margin-top: 10px;">
                <g:render template="searchresults" model="[allTemplates: allTemplates]"/>
            </div>
        </g:formRemote>

    </div>
    <div class="zusatz-show" id="templates2">
        <g:render template="templates" model="[group: group, templates: templates]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="resources.required"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${group}" checkstatus="${group}" checkoperator="true"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="resources" style="display:none">

        <g:formRemote name="formRemote" url="[controller: 'resourceProfile', action: 'addResource', id: group.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
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
        </g:formRemote>

    </div>
    <div class="zusatz-show" id="resources2">
        <g:render template="/requiredResources/resources" model="[template: group]"/>
    </div>
    <g:if test="${templateResources}">
        <p><span class="bold"><g:message code="fromTemplates"/>:</span></p>
        <div class="zusatz-show">
            <g:each in="${templateResources}" var="resource">
                <div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
                    <ul>
                        <li><span class="bold"><g:message code="name"/>:</span> ${resource.name}</li>
                        <li><g:message code="description"/>: ${resource.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
                        <li><g:message code="resource.profile.amount"/>: ${resource.amount}</li>
                    </ul>
                </div>
            </g:each>
        </div>
    </g:if>
</div>

<div class="zusatz">
    <h5><g:message code="template.plannedBlocks"/> (${instances.size}) <img onclick="toggle('#instances');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="Instanzen"/></h5>
    <div class="zusatz-add" id="instances" style="display:none">
        <g:if test="${instances.size() > 0}">
            <ul>
            <g:each in="${instances}" var="instance">
                <li style="list-style-type: disc"><g:link controller="groupActivityProfile" action="show" id="${instance.id}">${instance.profile.fullName}</g:link></li>
            </g:each>
        </g:if>
        <g:else>
        <g:message code="template.notPlannedYet"/>
        </g:else>
    </div>
</div>