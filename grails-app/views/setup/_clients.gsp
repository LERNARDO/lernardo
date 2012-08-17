<div class="zusatz">
    <h5><g:message code="familyStatus"/> <a onclick="clearElements(['#familyStatusName']); toggle('#familyStatus');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></h5>
    <div class="zusatz-add" id="familyStatus" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'setup', action: 'addElement', id: setupInstance.id, params: [type: 'familyStatus']]" update="familyStatus2" before="showspinner('#familyStatus2');" after="toggle('#familyStatus');">
            <g:textField id="familyStatusName" size="30" name="elementName" value=""/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="familyStatus2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'familyStatus']"/>
    </div>
</div>