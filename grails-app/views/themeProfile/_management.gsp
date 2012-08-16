<h4><g:message code="management"/></h4>

<div class="zusatz">
    <h5><g:message code="labels"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${theme}" checkoperator="true"><a onclick="toggle('#labels');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="labels" style="display:none">
        <g:formRemote name="formRemote2" url="[controller: 'themeProfile', action: 'addLabel', id: theme.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
            <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
        </g:formRemote>
    </div>
    <div class="zusatz-show" id="labels2">
        <g:render template="labels" model="[theme: theme]"/>
    </div>
</div>

<div class="zusatz">
    <h5><g:message code="projects"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#projects');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Projekte zuordnen"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="projects" style="display:none">
        <g:if test="${allProjects}">
            <g:formRemote name="formRemote" url="[controller: 'themeProfile', action: 'addProject', id: theme.id]" update="projects2" before="showspinner('#projects2');"  after="toggle('#projects');">
                <g:select name="project" from="${allProjects}" optionKey="id" optionValue="profile"/>
                <div class="clear"></div>
                <g:submitButton name="button" value="${message(code:'add')}"/>
                <div class="clear"></div>
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

<div class="zusatz">
    <h5><g:message code="groupActivities"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#activitygroups');
    return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Aktivitätsblöcke zuordnen"/></a></erp:accessCheck></h5>
    <div class="zusatz-add" id="activitygroups" style="display:none">
        <g:if test="${allActivityGroups}">
            <g:formRemote name="formRemote" url="[controller: 'themeProfile', action: 'addActivityGroup', id: theme.id]" update="activitygroups2" before="showspinner('#activitygroups2');" after="toggle('#activitygroups');">
                <g:select name="activitygroup" from="${allActivityGroups}" optionKey="id" optionValue="profile"/>
                <div class="clear"></div>
                <g:submitButton name="button" value="${message(code:'add')}"/>
                <div class="clear"></div>
            </g:formRemote>
        </g:if>
        <g:else>
            <g:message code="theme.noGroupActivities"/>
        </g:else>
    </div>
    <div class="zusatz-show" id="activitygroups2">
        <g:render template="activitygroups" model="[activitygroups: activitygroups, theme: theme]"/>
    </div>
</div>