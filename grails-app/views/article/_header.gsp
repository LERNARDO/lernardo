<div class="header">
  <div class="date">
    <g:isLoggedIn>
      (<g:link style="color:#a00;" class="adminlinks" action="edit" id="${article.id}">bearbeiten</g:link> - <g:link style="color:#a00;" class="adminlinks" action="delete" id="${article.id}">löschen</g:link>)
    </g:isLoggedIn>
${article.dateCreated} by ${article.author.profile.fullName}
  </div>
  <g:link controller="article" action="show" id="${article.id}">${article.title}</g:link>
</div>