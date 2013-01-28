<g:formRemote name="formRemote" url="[controller: 'goal', action: 'updateMainGoal', id: maingoal.id, params: [i: i]]" update="maingoal${i}" before="showspinner('#maingoal${i}');">
    <g:textField name="name" size="30" value="${maingoal.name}"/><br/>
    <g:textArea name="description" rows="10" cols="100" value="${maingoal.description}"/><br/>
    <g:submitButton name="button" value="${message(code: 'change')}"/>
</g:formRemote>