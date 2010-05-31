<div class="header">
  <div class="title">
    <g:link action="show" id="${article.id}">${article.title}</g:link>
  </div>
  <div class="info">
    von <span class="bold">
      <app:isNotLoggedIn>
        ${article.author.profile.fullName}
      </app:isNotLoggedIn>
      <app:isLoggedIn>
        <app:isEnabled entity="${article.author}">
          <g:link controller="${article.author.type.supertype.name +'Profile'}" action="show" id="${article.author.id}">${article.author.profile.fullName}</g:link>
        </app:isEnabled>
        <app:notEnabled entity="${article.author}">
          <span class="notEnabled">${article.author.profile.fullName}</span>
        </app:notEnabled>
      </app:isLoggedIn></span>
    am <g:formatDate format="dd. MMM. yyyy" date="${article.dateCreated}"/>
    um <g:formatDate format="HH:mm" date="${article.dateCreated}"/>
    <app:isLoggedIn>
      <app:isEducator entity="${currentEntity}">
        (<g:link class="adminlink" action="edit" id="${article.id}">bearbeiten</g:link> -
         <g:link class="adminlink" action="delete" onclick="return confirm('Artikel wirklich löschen?');" id="${article.id}">löschen</g:link>)
      </app:isEducator>
    </app:isLoggedIn>
  </div>
</div>