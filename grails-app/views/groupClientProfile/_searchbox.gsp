<g:if test="${allClients}">
  <g:select name="client" from="${allClients}" optionKey="id" optionValue="profile"/>
  <div class="spacer"></div>
    <g:submitButton name="button" value="${message(code:'add')}"/>
  <div class="spacer"></div>
</g:if>
<g:else>
  <span class="italic">Keine Treffer!</span>
</g:else>