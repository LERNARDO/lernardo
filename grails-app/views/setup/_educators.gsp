<div class="zusatz">
    <h5><g:message code="educations"/> <a onclick="clearElements(['#educationName']); toggle('#educations');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></h5>
    <div class="zusatz-add" id="educations" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'setup', action: 'addElement', id: setupInstance.id, params: [type: 'educations']]" update="educations2" before="showspinner('#educations2');" after="toggle('#educations');">
            <g:textField id="educationName" size="30" name="elementName" value=""/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="educations2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'educations']"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="employmentStatus"/> <a onclick="clearElements(['#employmentStatusName']); toggle('#employmentStatus');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></h5>
    <div class="zusatz-add" id="employmentStatus" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'setup', action: 'addElement', id: setupInstance.id, params: [type: 'employmentStatus']]" update="employmentStatus2" before="showspinner('#employmentStatus2');" after="toggle('#employmentStatus');">
            <g:textField id="employmentStatusName" size="30" name="elementName" value=""/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="employmentStatus2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'employmentStatus']"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="responsibilities"/> <a onclick="clearElements(['#responsibilityName']); toggle('#responsibilities');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></h5>
    <div class="zusatz-add" id="responsibilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'setup', action: 'addElement', id: setupInstance.id, params: [type: 'responsibilities']]" update="responsibilities2" before="showspinner('#responsibilities2');" after="toggle('#responsibilities');">
            <g:textField id="responsibilityName" size="30" name="elementName" value=""/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="responsibilities2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'responsibilities']"/>
    </div>
</div>