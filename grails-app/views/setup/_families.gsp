<div class="zusatz">
    <h5><g:message code="familyProblems"/> <a onclick="clearElements(['#familyProblemName']); toggle('#familyProblems');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></h5>
    <div class="zusatz-add" id="familyProblems" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'setup', action: 'addElement', id: setupInstance.id, params: [type: 'familyProblems']]" update="familyProblems2" before="showspinner('#familyProblems2');" after="toggle('#familyProblems');">
            <g:textField id="familyProblemName" size="30" name="elementName" value=""/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="familyProblems2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'familyProblems']"/>
    </div>
</div>