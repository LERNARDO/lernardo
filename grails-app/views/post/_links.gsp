  <div class="actionlink">
    <g:if test="${article.teaser}">
          <g:link action="show" id="${article.id}">&#187; mehr lesen</g:link>
    </g:if>
  </div>

  %{--<div>
    <ub:meOrAdmin entityName="${article.author}">
      <g:link class="adminlinks" action="edit" id="${article.id}">bearbeiten</g:link>
      <g:link class="adminlinks" action="delete" id="${article.id}">löschen</g:link>
    </ub:meOrAdmin>
    <ub:isAdmin>
      <g:link class="adminlinks" action="create" id="${article.id}">neuer artikel</g:link>
    </ub:isAdmin>
  </div>--}%
