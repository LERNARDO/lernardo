<div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #efefef; padding: 5px;">
  <g:formRemote name="formRemote" url="[controller: 'favorite', action: 'updateFavorite', id: favorite.id]" update="favoriteslist" before="showspinner('#favoriteslist');">
    <span class="gray">Name:</span> ${favorite.entity.profile.fullName}
    <span class="gray">Beschreibung:</span> <g:textField name="description" value="${favorite.description}"/>
    <span class="gray">Ordner:</span> <g:select name="folder" from="${folders}" optionKey="id" optionValue="name" noSelection="['none': 'keiner']" value="${favorite.folder.id}"/>
    <g:submitButton name="button" value="${message(code:'save')}"/>
  </g:formRemote>
</div>