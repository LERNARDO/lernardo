<g:formRemote name="formRemote" url="[controller:'projectTemplateProfile', action:'updateProjectUnitTemplate', id: projectUnitTemplate.id, params:[i: i]]" update="projectName${i}">
  <div class="dialog">
    <div class="value">
      <g:textField size="15" name="fullName" value="${projectUnitTemplate.profile.fullName}"/>
    </div>
  </div>
  <div class="buttons">
    <g:submitButton name="submitButton" value="${message(code:'change')}"/>
    <div class="spacer"></div>
  </div>
</g:formRemote>