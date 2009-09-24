<div class="article-teaser">
  <g:if test="${article.teaser}">
    <p class="teaser">${article.teaser}</p>
  </g:if>
  <g:else>
    ${article.content}
  </g:else>
</div>