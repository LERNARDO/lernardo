<g:formRemote name="formRemote" url="[controller: 'projectProfile', action: 'updateUnitName', id: unit.id, params: [i: i]]" update="unitName${i}" before="showspinner('#unitName${i}');">
    <g:textField name="fullName" required="" size="25" value="${unit.profile.fullName}"/>
    <g:submitButton name="button" value="${message(code:'save')}"/>
</g:formRemote>