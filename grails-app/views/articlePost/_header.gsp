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
        <app:isEnabled entityName="${article.author.name}">
          <g:link controller="profile" action="showProfile" params="[name:article.author.name]" >${article.author.profile.fullName}</g:link>
        </app:isEnabled>
        <app:notEnabled entityName="${article.author.name}">
          <span class="notEnabled">${article.author.profile.fullName}</span>
        </app:notEnabled>
      </app:isLoggedIn></span>
    am <g:formatDate format="dd. MMM. yyyy" date="${article.dateCreated}"/>
    um <g:formatDate format="HH:mm" date="${article.dateCreated}"/>
    <g:isLoggedIn>
      <app:isPaed entity="${currentEntity}">
        (<g:link class="adminlink" action="edit" id="${article.id}">bearbeiten</g:link> -
         <g:link class="adminlink" action="delete" onclick="return confirm('Artikel wirklich löschen?');" id="${article.id}">löschen</g:link>)
      </app:isPaed>
    </g:isLoggedIn>
  </div>
</div>