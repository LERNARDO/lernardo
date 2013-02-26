<g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'updateUnitDuration', id: unit.id, params: [i: i]]" update="unitDuration${i}" before="showspinner('#unitDuration${i}');">
    <g:textField name="duration" required="" size="4" value="${unit.profile.duration}"/>
    <g:submitButton name="button" value="${message(code:'save')}"/>
</g:formRemote>