<div class="article-header">
  <div class="article-date"> ${article.dateCreated} by ${article.author}</div>
  %{-- This link doesn't output the controller and action --}%
  <g:link action="show" id="${article.id}">${article.title}</g:link>
  <g:set var="articleID" value="${article.id}" />
  %{-- This link doesn't add the parameters --}%
  <g:link url="/lernardoV2/article/show" params="[id:articleID]" id="${article.id}">${article.title}</g:link>
</div>