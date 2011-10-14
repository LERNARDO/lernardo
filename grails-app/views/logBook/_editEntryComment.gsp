<g:formRemote name="formRemote" url="[controller:'logBook', action:'updateEntryComment', id: entry.id]" update="comment" before="showspinner('#comment');">
  <g:textArea rows="10" cols="50" name="comment" value="${entry.comment}"/><br/>
  <g:submitButton name="button" value="${message(code:'save')}"/>
</g:formRemote>