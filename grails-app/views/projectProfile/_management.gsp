<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="responsible"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#responsible');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
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
    <h5><g:message code="clients"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#clients');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="clients" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${project.id}" before="showspinner('#remoteClients');"/>
        <div id="remoteClients"></div>

    </div>
    <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, project: project]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="educators"/> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><img onclick="toggle('#educators');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="educators" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteEducators" action="remoteEducators" id="${project.id}" before="showspinner('#remoteEducators');"/>
        <div id="remoteEducators"></div>

    </div>
    <div class="zusatz-show" id="educators2">
        <g:render template="educators" model="[educators: educators, project: project]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="resources.required"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${project}" checkstatus="${project}" checkoperator="true"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="resources" style="display:none">

        <g:formRemote name="formRemote" url="[controller: 'resourceProfile', action: 'addResource', id: project.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
            <table>
                <tr>
                    <td><g:message code="name"/>:</td>
                    <td><g:textField id="resourceName" size="30" name="name" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="description"/>:</td>
                    <td><g:textArea id="resourceDescription" rows="5" cols="50" name="description" value=""/></td>
                </tr>
                <tr>
                    <td><g:message code="resource.profile.amount"/>:</td>
                    <td><g:textField size="5" name="amount" value="1"/></td>
                </tr>
            </table>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>

    </div>
    <div class="zusatz-show" id="resources2">
        <g:render template="/requiredResources/resources" model="[template: project]"/>
    </div>
</div>