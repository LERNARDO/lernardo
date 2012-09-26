<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="responsible"/> <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#responsible');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="responsible" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteResponsible" action="remoteResponsible" id="${project.id}" before="showspinner('#remoteResponsible');"/>
        <div id="remoteResponsible"></div>

    </div>
    <div class="zusatz-show" id="responsible2">
        <g:render template="responsible" model="[responsibles: responsibles, project: project]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="themes"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#themes');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="Zu Thema zuordnen"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="themes" style="display:none">
        <g:if test="${allThemes}">
            <g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'addTheme', id: project.id]" update="themes2" before="showspinner('#themes2');"  after="toggle('#themes');">
                <g:select name="theme" from="${allThemes}" optionKey="id" optionValue="profile"/>
                <div class="clear"></div>
                <g:submitButton name="button" value="${message(code:'add')}"/>
            </g:formRemote>
        </g:if>
        <g:else>
            <g:message code="project.noThemes"/>
        </g:else>
    </div>
    <div class="zusatz-show" id="themes2">
        <g:render template="themes" model="[themes: themes, project: project]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="facility"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><span id="facilitybutton"><g:render template="facilitybutton" model="[facilities: facilities]"/></span></erp:accessCheck></h5>
    <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'addFacility', id: project.id]" update="facilities2" before="showspinner('#facilities2'); toggle('#facilities');" after="${remoteFunction(action: 'updateFacilityButton', update: 'facilitybutton', id: project.id)}">
            <table>
                <tr>
                    <td style="padding: 5px 10px 0 0;"><g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/></td>
                    <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
                </tr>
            </table>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, project: project]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="clients"/> <span id="clientsSize"></span> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#clients');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="clients" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${project.id}" before="showspinner('#remoteClients');"/>
        <div id="remoteClients"></div>

    </div>
    <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients]"/>
    </div>
</div>