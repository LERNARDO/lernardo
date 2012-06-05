<div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #efefef; padding: 5px;">
  <g:formRemote name="formRemote" url="[controller: 'favorite', action: 'saveFolder']" update="favoriteslist" before="showspinner('#favoriteslist');">
    <span class="gray">Name:</span> <g:textField name="name"/>
    <span class="gray">Beschreibung:</span> <g:textField name="description" size="50"/>
    <span class="gray">Ordner:</span> <g:select name="folder" from="${folders}" optionKey="id" optionValue="name" noSelection="['none': 'keiner']"/>
    <g:submitButton name="button" value="${message(code:'add')}"/>
  </g:formRemote>
</div>