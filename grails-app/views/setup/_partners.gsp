<div class="zusatz">
    <h5><g:message code="partnerServices"/> <a onclick="clearElements(['#partnerServiceName']); toggle('#partnerServices');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></h5>
    <div class="zusatz-add" id="partnerServices" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'setup', action: 'addElement', id: setupInstance.id, params: [type: 'partnerServices']]" update="partnerServices2" before="showspinner('#partnerServices2');" after="toggle('#partnerServices');">
            <g:textField id="partnerServiceName" size="30" name="elementName" value=""/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="partnerServices2">
        <g:render template="allElements" model="[setupInstance: setupInstance, type: 'partnerServices']"/>
    </div>
</div>