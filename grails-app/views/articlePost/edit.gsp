<head>
  <title>Artikel bearbeiten</title>
  <meta name="layout" content="public" />
</head>

<body>
  <h1>Artikel bearbeiten</h1>

  <g:hasErrors bean="${postInstance}">
    <div class="errors">
      <g:renderErrors bean="${postInstance}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form action="update" method="post" id="${postInstance.id}">

    <p><span class="strong">Titel</span><br/>
    <span class="${hasErrors(bean: postInstance, field: 'title', 'errors')}"><g:textField class="countable${postInstance.constraints.title.maxSize}" name="title" size="100" value="${fieldValue(bean:postInstance,field:'title').decodeHTML()}"/></span></p>

    <p><span class="strong">Teaser</span><br/>
    <span class="${hasErrors(bean: postInstance, field: 'teaser', 'errors')}"><g:textArea class="countable${postInstance.constraints.teaser.maxSize}" name="teaser" rows="3" cols="100" value="${fieldValue(bean:postInstance,field:'teaser').decodeHTML()}"/></span>
    <br/><span class="gray">(der Teaser ist optional und muss nicht ausgefüllt werden)</span></p>
    
    <span class="strong">Inhalt</span>
    <span class="${hasErrors(bean: postInstance, field: 'content', 'errors')}">
      <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
      <fckeditor:editor name="content" height="400" toolbar="Post" fileBrowser="default">
        ${fieldValue(bean:postInstance,field:'content').decodeHTML()}
      </fckeditor:editor>
    </span>

    <div class="buttons">
      <g:submitButton name="submitButton" value="Speichern"/>
      <g:link action="index">Abbrechen</g:link>
    </div>

    <br/>
  </g:form>
</body>