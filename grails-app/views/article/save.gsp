<%--
  Created by IntelliJ IDEA.
  User: mkuhl
  Date: 19.07.2009
  Time: 18:08:12
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Artikel gespeichert</title></head>
  <body>
    <g:hasErrors>
      <div class="error">
        <g:eachError><p>${it.defaultMessage}</p></g:eachError>
      </div>
    </g:hasErrors>
    
  </body>
</html>