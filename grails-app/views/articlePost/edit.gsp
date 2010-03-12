<head>
  <title>Lernardo | Artikel bearbeiten</title>
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
    <span class="${hasErrors(bean: postInstance, field: 'title', 'errors')}"><g:textField name="title" size="100" value="${fieldValue(bean:postInstance,field:'title').decodeHTML()}"/></span></p>

    <p><span class="strong">Teaser</span>
    <span class="${hasErrors(bean: postInstance, field: 'teaser', 'errors')}"><g:textArea name="teaser" rows="3" cols="100" value="${fieldValue(bean:postInstance,field:'teaser').decodeHTML()}"/></span>
    <span class="gray">(der Teaser ist optional und muss nicht ausgefüllt werden)</span></p>
    
    <span class="strong">Inhalt</span>
    <span class="${hasErrors(bean: postInstance, field: 'content', 'errors')}">
      <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js').toString()}"/>
      <fckeditor:editor name="content" height="400" toolbar="Post" fileBrowser="default">
        ${fieldValue(bean:postInstance,field:'content').decodeHTML()}
      </fckeditor:editor>
    </span>

    <div class="buttons">
      <g:submitButton name="submitButton" value="Aktualisieren"/>
      <g:link action="index">Abbrechen</g:link>
    </div>

    <br/>
  </g:form>
</body>