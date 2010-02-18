<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Lernardo | Profilbild hochladen</title>
    %{--<meta name="layout" content="private" />--}%
  </head>
  <body>
  <h1>Profilbild</h1>
  <g:uploadForm action="putprf">
    <p>Bitte ein Bild auswählen:<br/>
    <input size="40" type="file" name="asset"></p>

    <p>Zur optimalen Darstellung ist ein Bildformat von 180 x 233 px empfehlenswert.</p>
    <g:submitButton name="submit" value="Ändern"/>
  </g:uploadForm>
  </body>
</html>