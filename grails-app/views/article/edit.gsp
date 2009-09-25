<html>
  <head>
    <title>Artikel editieren</title>
    <meta name="layout" content="public" />
  </head>

  <body>
    <g:form action="save" name="editform" class="dialog" id='$article.id'>
      <fieldset>
        <legend>Eintrag editieren</legend>

        <label for="title">Titel</label>
        <g:textField class="text" name="title" id="atitle" value="${article.title}"></g:textField>
        <br/>

        <label for="teaser">Teaser</label>
        <g:textArea name="teaser">${article.teaser}</g:textArea>
        <br/>

        <label for="atext">Text</label>
        <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
        %{--<fckeditor:config ToolbarStartExpanded ="false"/>--}%

        <fckeditor:editor name="atext" id="atext" width="100%" height="400" toolbar="Article" fileBrowser="default">
          ${article.content}
        </fckeditor:editor>
        %{--<g:textArea name="atext" id="atext">${article.content}</g:textArea>--}%
        <br/>

        <div class="buttonbar">
          <g:submitButton name="preview" value="Vorschau"></g:submitButton>
          <g:submitButton name="submit" id="save" value="Fertig"></g:submitButton>
        </div>
      </fieldset>
      <br/>
    </g:form>
  </body>
</html>