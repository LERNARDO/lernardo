<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Tagebucheintrag bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Tagebucheintrag bearbeiten</h1>
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

      <p class="strong">Beschreibung</p>
      <span class="${hasErrors(bean: evaluationInstance, field: 'description', 'errors')}">
        <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
        <fckeditor:editor name="description" height="200" toolbar="Basic" fileBrowser="default">
          ${fieldValue(bean: evaluationInstance, field: 'description').decodeHTML()}
        </fckeditor:editor>
      </span>

      <p class="strong">Maßnahme</p>
      <span class="${hasErrors(bean: evaluationInstance, field: 'method', 'errors')}">
        <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
        <fckeditor:editor name="method" height="200" toolbar="Basic" fileBrowser="default">
          ${fieldValue(bean: evaluationInstance, field: 'method').decodeHTML()}
        </fckeditor:editor>
      </span>

      <div class="buttons">
        <g:submitButton name="submitButton" value="Speichern"/>
        <g:link class="buttonRed" action="del" id="${evaluationInstance.id}" params="[name:entity.name]" onclick="return confirm('${message(code:'delete.warn')}');">Löschen</g:link>
        <g:link class="buttonGray" action="list" id="${entity.id}">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
