<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="pate.profile.gcs"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#godchildren');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="godchildren" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${pate.id}" before="showspinner('#remoteClients')"/>
        <div id="remoteClients"></div>

    </div>
    <div class="zusatz-show" id="godchildren2">
        <g:render template="godchildren" model="[godchildren: godchildren, pate: pate]"/>
    </div>
</div>