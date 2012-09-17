<div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #efefef; padding: 5px;">
  <g:formRemote name="formRemote" url="[controller: 'favorite', action: 'saveFolder']" update="favoriteslist" before="showspinner('#favoriteslist');">
    <span class="gray"><g:message code="name"/></span> <g:textField name="name"/>
    <span class="gray"><g:message code="description"/></span> <g:textField name="description" size="50"/>
    <span class="gray"><g:message code="folder"/></span> <g:select name="folder" from="${folders}" optionKey="id" optionValue="name" noSelection="['none': 'keiner']"/>
    <g:submitButton name="button" value="${message(code:'add')}"/>
  </g:formRemote>
</div>