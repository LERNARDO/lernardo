<html>

  <head>
    <title>News</title>
    <meta name="layout" content="public" />
  </head>

  <body>
    <div id="article-index">
      <h1>${listTitle ?: articles ? articles[0].category.description : "Keine Artikel gefunden" }</h1>

      <!-- render all articles -->


      <g:each var="article" in="${articles}">
        <div class="article-index-item">
%{--<g:render template="header" model="articleInstance"/>
<g:render template="teaser" model=[article:articleInstance]/>
<g:render template="links"  model=[article:articleInstance]/>--}%
          <div class="article-header">
            <div class="article-date"> ${article.value.dateCreated} by ${article.value.author}</div>
            <g:link action="show" id="${article.value.id}" >${article.value.title}</g:link>
          </div>
          <div class="article-teaser">
            <g:if test="${article.value.teaser}">
              <p class="teaser">${article.value.teaser}</p>
            </g:if>
            <g:else>
${article.value.content}
            </g:else>
          </div>
          <div class="article-links actionlinks">

            <div class="userlinks">
              <g:if test="${article.value.teaser}">
                <g:link class="more" action="show" id="${article.value.id}" >mehr lesen</g:link>
              </g:if>
            </div>
          </div>
        </div>
      </g:each>

    </div>
  </body>

</html>