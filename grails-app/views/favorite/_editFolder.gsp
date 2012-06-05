<g:formRemote name="formRemote" url="[controller: 'favorite', action: 'updateFolder', id: folder.id]" update="favoriteslist" before="showspinner('#favoriteslist');">
  Name: <g:textField name="name" value="${folder.name}"/>
  Beschreibung: <g:textField name="description" value="${folder.description}"/>
  Ordner: <g:select name="folder" from="${folders}" optionKey="id" optionValue="name" noSelection="['none': 'keiner']" value="${folder.folder.id}"/>
  <g:submitButton name="button" value="${message(code:'save')}"/>
</g:formRemote>