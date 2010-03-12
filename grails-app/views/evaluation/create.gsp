<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Beurteilung erstellen</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Beurteilung erstellen</h1>
  </div>
  <div class="boxGray">

    <g:hasErrors bean="${evaluationInstance}">
    <div class="errors">
        <g:renderErrors bean="${evaluationInstance}" as="list" />
    </div>
    </g:hasErrors>

    <g:form action="save" method="post" params="[entity:entity.id]">

      <span class="strong">Beschreibung</span>
      <span class="${hasErrors(bean: evaluationInstance, field: 'description', 'errors')}">
        <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
        <fckeditor:editor name="description" height="200" toolbar="Post" fileBrowser="default">
          ${fieldValue(bean:evaluationInstance,field:'description').decodeHTML()}
        </fckeditor:editor>
      </span>

      <span class="strong">Maßnahme</span>
      <span class="${hasErrors(bean: evaluationInstance, field: 'method', 'errors')}">
        <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
        <fckeditor:editor name="method" height="200" toolbar="Post" fileBrowser="default">
          ${fieldValue(bean:evaluationInstance,field:'method').decodeHTML()}
        </fckeditor:editor>
      </span>

      <div class="buttons">
          <g:submitButton name="submitButton" value="Erstellen" />
          <g:link class="buttonGray" action="list" params="[name:entity.name]">Abbrechen</g:link>
          <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</body>
