<g:formRemote name="formRemote" url="[controller:'resourceProfile', action:'updateResource', id: template.id, params: [resource: resource.id, i: i]]" update="resource${i}" before="showspinner('#resource${i}');">
  <table>
    <tr>
      <td><g:message code="name"/>:</td>
      <td><g:textField id="resourceName" size="30" name="name" value="${resource.name}"/></td>
    </tr>
    <tr>
      <td><g:message code="description"/>:</td>
      <td><g:textArea id="resourceDescription" rows="5" cols="50" name="description" value="${resource.description}"/></td>
    </tr>
    <tr>
      <td><g:message code="resource.profile.amount"/>:</td>
      <td><g:textField size="5" name="amount" value="${resource.amount}"/></td>
    </tr>
  </table>
  <div class="spacer"></div>
  <g:submitButton name="button" value="${message(code:'save')}"/>
  <div class="spacer"></div>
</g:formRemote>