<div class="article-header">
  <div class="article-date"> (<g:link style="color:#a00;" class="adminlinks" action="edit" id="${article.id}">bearbeiten</g:link> - <g:link style="color:#a00;" class="adminlinks" action="delete" id="${article.id}">löschen</g:link>)
${article.dateCreated} by ${article.author}</div>

%{-- Bug? This link doesn't output the controller and action --}%
  <g:link controller="article" action="show" id="${article.id}">${article.title}</g:link>

  <g:set var="articleID" value="${article.id}" />
%{-- Bug? This link doesn't add the parameters
<g:link url="/lernardoV2/article/show" params="[id:articleID]" id="${article.id}">${article.title}</g:link>--}%

</div>