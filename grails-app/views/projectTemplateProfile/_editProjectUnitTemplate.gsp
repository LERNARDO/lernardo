<g:formRemote name="formRemote" url="[controller:'projectTemplateProfile', action:'updateProjectUnitTemplate', id: projectUnitTemplate.id, params:[i: i]]" update="projectName${i}">
  <div>
    <div class="value">
      <g:textField size="15" name="fullName" value="${projectUnitTemplate.profile.fullName}"/>
    </div>
  </div>
  <g:submitButton name="submitButton" value="${message(code:'change')}"/>
</g:formRemote>