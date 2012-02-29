<g:formRemote name="formRemote" url="[controller:'resourceProfile', action:'updateResource', id: template.id, params: [resourceInstance: resourceInstance.id, i: i]]" update="resource${i}" before="showspinner('#resource${i}');">
  <table>
    <tr>
      <td><g:message code="name"/>:</td>
      <td><g:textField id="resourceName" size="30" name="name" value="${resourceInstance.name}"/></td>
    </tr>
    <tr>
      <td><g:message code="description"/>:</td>
      <td><g:textArea id="resourceDescription" rows="5" cols="50" name="description" value="${resourceInstance.description}"/></td>
    </tr>
    <tr>
      <td><g:message code="resource.profile.amount"/>:</td>
      <td><g:textField size="5" name="amount" value="${resourceInstance.amount}"/></td>
    </tr>
  </table>
  <div class="clear"></div>
  <g:submitButton name="button" value="${message(code:'save')}"/>
  <div class="clear"></div>
</g:formRemote>