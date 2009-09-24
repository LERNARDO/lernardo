
<div class="article-links actionlinks">

  <div class="userlinks">
    <g:if test="${isTeaser && article.teaser}">
          <g:link class="more" action="show" id="${article.id}" >mehr lesen</g:link>
    </g:if>
  </div>

  <div>
    <ub:meOrAdmin entityName="${article.author.name}">
      <g:link class="adminlinks" action="edit" id="${article.id}">bearbeiten</g:link>
      <g:link class="adminlinks" action="delete" id="${article.id}">löschen</g:link>
    </ub:meOrAdmin>
    <ub:isAdmin>
      <g:link class="adminlinks" action="create" id="${article.id}">neuer artikel</g:link>
    </ub:isAdmin>
  </div>

</div>
