<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="labels"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><img onclick="toggle('#labels');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="labels" style="display:none">
        <g:formRemote name="formRemote2" url="[controller: 'templateProfile', action: 'addLabel', id: template.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
            <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="labels2">
        <g:render template="labels" model="[template: template]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="resources.required"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="resources" style="display:none">

        <g:formRemote name="formRemote" url="[controller: 'resourceProfile', action: 'addResource', id: template.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
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
        <g:render template="/requiredResources/resources" model="[template: template]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="vMethods"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><img onclick="toggle('#methods');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="methods" style="display:none">
        <g:formRemote name="formRemote2" url="[controller: 'templateProfile', action: 'addMethod', id: template.id]" update="methods2" before="showspinner('#methods2');" after="toggle('#methods');">
            <g:select name="method" from="${allMethods}" optionKey="id" optionValue="name"/>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="methods2">
        <g:render template="methods" model="[template: template]"/>
    </div>
</div>