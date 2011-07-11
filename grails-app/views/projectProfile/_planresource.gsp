<g:formRemote name="formRemote" url="[controller:'projectProfile', action:'planresourcenow', id: projectDay.id, params: [resource: resource.id]]" update="resources2" before="showspinner('#resources2');" after="${remoteFunction(action: 'refreshplannableresources', update: 'plannableresources', id: projectDay.id)}">
  <g:message code="resource.profile.amount"/>: <g:select from="${1..resourceFree}" name="amount" value="1"/>
  <g:submitButton name="button" value="OK"/>
</g:formRemote>