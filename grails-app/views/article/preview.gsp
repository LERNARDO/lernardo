<%--
  Created by IntelliJ IDEA.
  User: mkuhl
  Date: 19.07.2009
  Time: 16:28:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>


<head>
  <title>${article.title}</title>
  <meta name="layout" content="public" />
</head>

<body>
  <h2>Artikel Vorschau</h2>
  <br />
  <div id="article-detail">
    <g:render template="header"     model='[article:article]'/>
    <g:render template="content"    model='[article:article]'/>
  </div>
  <br/>
  <input type="button" value="Zurück" onClick="history.go(-1);">


</body>
