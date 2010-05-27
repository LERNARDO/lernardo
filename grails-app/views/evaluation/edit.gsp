<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Beurteilung bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Beurteilung bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${evaluationInstance}">
      <div class="errors">
        <g:renderErrors bean="${evaluationInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${evaluationInstance.id}" params="[name:entity.name]">

      <span class="strong">Beschreibung</span>
      <span class="${hasErrors(bean: evaluationInstance, field: 'description', 'errors')}">
        <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
        <fckeditor:editor name="description" height="200" toolbar="Post" fileBrowser="default">
          ${fieldValue(bean: evaluationInstance, field: 'description').decodeHTML()}
        </fckeditor:editor>
      </span>

      <span class="strong">Maßnahme</span>
      <span class="${hasErrors(bean: evaluationInstance, field: 'method', 'errors')}">
        <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
        <fckeditor:editor name="method" height="200" toolbar="Post" fileBrowser="default">
          ${fieldValue(bean: evaluationInstance, field: 'method').decodeHTML()}
        </fckeditor:editor>
      </span>

      <div class="buttons">
        <g:submitButton name="submitButton" value="Speichern"/>
        <g:link class="buttonBlue" action="del" id="${evaluationInstance.id}" params="[name:entity.name]" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
        <g:link class="buttonGray" action="list" params="[name:entity.name]">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
