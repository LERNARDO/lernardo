<div class="header">
  <div class="title">
    <g:link action="show" id="${article.id}">${article.title}</g:link>
  </div>
  <div class="info">
    von <span class="bold">${article.author.profile.fullName}</span>
    am <g:formatDate format="dd. MMM. yyyy" date="${article.dateCreated}"/>
    um <g:formatDate format="HH:mm" date="${article.dateCreated}"/>
    <g:isLoggedIn>
      %{--<g:if test="${currentEntity.type.name == "Paed"}">--}%
        (<g:link class="adminlink" action="edit" id="${article.id}">bearbeiten</g:link> -
         <g:link class="adminlink" action="delete" onclick="return confirm('Artikel wirklich löschen?');" id="${article.id}">löschen</g:link>)
      %{--</g:if>--}%
    </g:isLoggedIn>
  </div>
</div>