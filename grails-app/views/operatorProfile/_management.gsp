<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="facilities"/> <erp:accessCheck me="${operator}"><a onclick="toggle('#facilities'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'operatorProfile', action: 'addFacility', id: operator.id]" update="facilities2" before="showspinner('#facilities2')">
            <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, operator: operator]"/>
    </div>
</div>