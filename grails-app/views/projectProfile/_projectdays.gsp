<div class="zusatz">
    <h5><g:message code="projectDays"/> (${projectDays.size()})</h5>
    <div id="projectDay">
        <g:render template="projectdaynav" model="[project: project, projectDays: projectDays, projectDay: day, resources: resources, allEducators: allEducators, allParents: allParents, units: units, active: active, plannableResources: plannableResources, requiredResources: requiredResources]"/>
    </div>
</div>