<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Lernardo | Profilbild hochgeladen</title>
    %{--<meta name="layout" content="private" />--}%
  </head>
  <body>
    <h1>Profilbild</h1>
      <g:if test="${asset}">
        Dein Profilbild wurde erfolgreich aktualisiert!
      </g:if>
      <g:else>
        Dein Profilbild konnten nicht aktualisiert werden!
      </g:else>
      <g:link controller="profile" action="showProfile">zurück zum Profil</g:link>
  </body>
</html>