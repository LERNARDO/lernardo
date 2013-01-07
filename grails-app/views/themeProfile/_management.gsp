<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="responsible"/> <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#responsible');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="responsible" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteResponsible" action="remoteResponsible" id="${theme.id}" before="showspinner('#remoteResponsible');"/>
        <div id="remoteResponsible"></div>

    </div>
    <div class="zusatz-show" id="responsible2">
        <g:render template="responsible" model="[responsibles: responsibles, theme: theme]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="projects"/> <erp:accessCheck types="['Betreiber']"><img onclick="toggle('#projects');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="Projekte zuordnen"/></erp:accessCheck></h5>
    <div class="zusatz-add" id="projects" style="display:none">
        <g:if test="${allProjects}">
            <g:formRemote name="formRemote" url="[controller: 'themeProfile', action: 'addProject', id: theme.id]" update="projects2" before="showspinner('#projects2');"  after="toggle('#projects');">
                <g:select name="project" from="${allProjects}" optionKey="id" optionValue="profile"/>
                <div class="clear"></div>
                <g:submitButton name="button" value="${message(code:'add')}"/>
            </g:formRemote>
        </g:if>
        <g:else>
            <g:message code="theme.noProjects"/>
        </g:else>
    </div>
    <div class="zusatz-show" id="projects2">
        <g:render template="projects" model="[projects: projects, theme: theme]"/>
    </div>
</div>