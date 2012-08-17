<div class="zusatz">
    <h5><g:message code="maritalStatus"/> <a onclick="clearElements(['#maritalStatusName']); toggle('#maritalStatus');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></h5>
    <div class="zusatz-add" id="maritalStatus" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'setup', action: 'addElement', id: setupInstance.id, params: [type: 'maritalStatus']]" update="maritalStatus2" before="showspinner('#maritalStatus2');" after="toggle('#maritalStatus');">
            <g:textField id="maritalStatusName" size="30" name="elementName" value=""/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="maritalStatus2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'maritalStatus']"/>
    </div>
</div>