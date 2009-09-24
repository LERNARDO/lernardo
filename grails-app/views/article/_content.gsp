<div class="article-content">

  <g:if test="${article.teaser}">
    <p class="teaser">${article.teaser}</p>
  </g:if>

  <g:if test="${article.content}">
    ${article.content}
  </g:if>

  <g:link action="index">Zurück zur Übersicht</g:link>
</div>
