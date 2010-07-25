<head>
  <title>Profilbild hochladen</title>
  <meta name="layout" content="private" />
</head>
<body>
  <div class="headerGreen">
    <div class="second">
      <h1>Profilbild ändern</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">
      <g:uploadForm controller="asset" action="putprf" params="[entity: entity.name]">
        <p>Bitte ein Bild auswählen:<br/>
        <input size="40" type="file" name="asset"></p>

        <p>Zur optimalen Darstellung ist ein Bildformat von 180 x 233 px empfehlenswert.</p>

        <div class="buttons">
          <g:submitButton name="submit" value="Speichern"/>
          <g:link class="buttonGray" controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}">Abbrechen</g:link>
          <div class="spacer"></div>
        </div>
        
      </g:uploadForm>
    </div>
  </div>
</body>