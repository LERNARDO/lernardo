<head>
  <title>Lernardo | Profilbild hochladen</title>
  <meta name="layout" content="private" />
</head>
<body>
  <div class="headerBlue">
    <h1>Profilbild ändern</h1>
  </div>
  <div class="boxGray">
    <g:uploadForm action="putprf">
      <p>Bitte ein Bild auswählen:<br/>
      <input size="40" type="file" name="asset"></p>

      <p>Zur optimalen Darstellung ist ein Bildformat von 180 x 233 px empfehlenswert.</p>

      <g:submitButton name="submit" value="Ändern"/>
      <g:link class="buttonGray" controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}">Abbrechen</g:link>
      <div class="spacer"></div>
   
    </g:uploadForm>
  </div>
</body>