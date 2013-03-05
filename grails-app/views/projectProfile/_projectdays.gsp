<div class="zusatz">
    <h5><g:message code="projectDays"/> (${projectDays})</h5>
    <div id="projectDay">
        %{--<g:render template="projectdaynav" model="[project: project, projectDays: projectDays, projectDay: day, resources: resources, allEducators: allEducators, allParents: allParents, allPartners: allPartners, active: active, plannableResources: plannableResources, requiredResources: requiredResources]"/>
    --}%</div>
</div>

<script type="text/javascript">
    $(function() {
        ${remoteFunction(action: 'setprojectday', update: 'projectDay', id: day, params: [project: project.id], before: "showspinner('#projectDay')")}
    });
</script>