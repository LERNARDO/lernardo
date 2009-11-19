<div class="header">
  <div class="date">
    <g:isLoggedIn>
      (<g:link style="color:#a00;" class="adminlinks" action="edit" id="${article.id}">bearbeiten</g:link> -
       <g:link style="color:#a00;" class="adminlinks" action="delete" id="${article.id}">löschen</g:link>)
    </g:isLoggedIn>
    gepostet am <g:formatDate format="dd. MMM. yyyy" date="${article.dateCreated}"/>
    um <g:formatDate format="HH:mm" date="${article.dateCreated}"/> von ${article.author.profile.fullName}
  </div>
  <g:link action="show" id="${article.id}">${article.title}</g:link>
</div>