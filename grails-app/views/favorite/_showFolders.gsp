<ul>
  <g:each in="${folders}" var="folder">
    <g:each in="${favorites}" var="favorite">
      <li style="line-height: 22px;">${favorite.entity.profile.fullName} <span class="gray">${favorite.description}</span></li>
    </g:each>
    <li style="line-height: 22px;">${folder.name} <span class="gray">${folder.description}</span></li>
    <erp:showFolders folder="${folder}">
      <g:render template="showFolders" model="[folders: subfolders, favorites: subfavorites]"/>
    </erp:showFolders>
  </g:each>
</ul>