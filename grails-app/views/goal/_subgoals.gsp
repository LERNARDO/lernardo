<g:each in="${maingoal.subGoals}" var="subgoal">
    %{-- weird bug here, subgoal.id is null??? --}%
    <div class="item sub">
        <div ><g:link action="show_new" id="${subgoal.id}">${subgoal.name}</g:link> <img src="${resource(dir: 'images/icons', file: 'icon_edit2.png')}" alt="mail" style="top: 1px; position: relative"/> <g:remoteLink action="removeSubGoal" id="${maingoal.id}" params="[subgoal: subgoal.id, i: i]" update="subgoals${i}"><img src="${resource(dir: 'images/icons', file: 'icon_remove_old.png')}" alt="mail" style="top: 1px; position: relative"/></g:remoteLink></div>
        <div class="description">${subgoal.description}</div>
    </div>
</g:each>