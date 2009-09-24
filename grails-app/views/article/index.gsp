<%--
  Created by IntelliJ IDEA.
  User: mkuhl
  Date: 19.07.2009
  Time: 15:42:48
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
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
          <g:render template="header" model='[article:article]'/>
          <g:render template="teaser" model='[article:article]'/>
          <g:render template="links"  model='[article:article, isTeaser:true]'/>
        </div>
      </g:each>

    </div>
  </body>

</html>