<html>
  <head>
    <title>Artikel editieren</title>
    <meta name="layout" content="public" />
  </head>

  <body>
    <g:form action="update" name="editform" class="dialog" id='postInstance.id'>
      <fieldset>
        <legend>Eintrag editieren</legend>

        <label for="title">Titel</label>
        <g:textField class="text" name="title" id="atitle">${postInstance.title}</g:textField>
        <br/>

        <label for="teaser">Teaser</label>
        <g:textArea name="teaser" rows="3" cols="100">${postInstance.teaser}</g:textArea>
        <br/>

        <label for="atext">Text</label>
        <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
        %{--<fckeditor:config ToolbarStartExpanded ="false"/>--}%

        <fckeditor:editor name="atext" id="atext" width="100%" height="400" toolbar="Post" fileBrowser="default">
          ${postInstance.content}
        </fckeditor:editor>
        %{--<g:textArea name="atext" id="atext">${article.content}</g:textArea>--}%
        <br/>

        <div class="buttonbar">
          <g:submitButton name="preview" value="Vorschau"></g:submitButton>
          <g:submitButton name="submit" id="update" value="Fertig"></g:submitButton>
        </div>
      </fieldset>
      <br/>
    </g:form>
  </body>
</html>