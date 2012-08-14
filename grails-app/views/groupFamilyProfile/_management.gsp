<h4><g:message code="management"/></h4>

<div id="familyCount">
    <g:render template="familycount" model="[totalLinks: totalLinks]"/>
</div>

<div class="zusatz">
    <h5><g:message code="parents"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#parents');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="parents" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteParents" action="remoteParents" id="${group.id}" before="showspinner('#remoteParents');"/>
        <div id="remoteParents"></div>

    </div>
    <div class="zusatz-show" id="parents2">
        <g:render template="parents" model="[parents: parents, group: group]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="clients"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#clients');
    return false" href="#" id="show-clients"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="clients" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${group.id}" before="showspinner('#remoteClients');"/>
        <div id="remoteClients"></div>

    </div>
    <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, group: group]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="children"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#childs');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="childs" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteChildren" action="remoteChildren" id="${group.id}" before="showspinner('#remoteChildren');"/>
        <div id="remoteChildren"></div>

    </div>
    <div class="zusatz-show" id="childs2">
        <g:render template="childs" model="[childs: childs, group: group]"/>
    </div>
</div>