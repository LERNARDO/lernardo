<html>
  <head>
    <title>Lernardo | Artikel bearbeiten</title>
    <meta name="layout" content="public" />
  </head>

  <body>
    <g:form action="update" id="${postInstance.id}">
        <h1>Artikel bearbeiten</h1>

        <p><span class="strong">Titel</span><br/>
        <g:textField name="title" size="100" value="${fieldValue(bean:postInstance,field:'title').decodeHTML()}"/></p>

        <p><span class="strong">Teaser</span>
        <g:textArea name="teaser" rows="3" cols="100" value="${fieldValue(bean:postInstance,field:'teaser').decodeHTML()}"/></p>

        <span class="strong">Inhalt</span>
        <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
        <fckeditor:editor name="content" height="400" toolbar="Post" fileBrowser="default">
          ${fieldValue(bean:postInstance,field:'content').decodeHTML()}
        </fckeditor:editor>

        <div class="buttons">
          <g:submitButton name="submitButton" value="Aktualisieren"/>
          <g:link action="index">Abbrechen</g:link>
        </div>
        
      <br/>
    </g:form>
  </body>
</html>