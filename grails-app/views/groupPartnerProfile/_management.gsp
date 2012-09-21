<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="partners"/> <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#partners');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="partners" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'groupPartnerProfile', action: 'addPartner', id: group.id]" update="partners2" before="showspinner('#partners2')">
            <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="partners2">
        <g:render template="partners" model="[partners: partners, group: group]"/>
    </div>
</div>