<html>
  <head>
    <title>Artikel editieren</title>
    <meta name="layout" content="public" />
  </head>

  <body>
    <g:form action="update" name="editform" class="dialog" id='${postInstance.id}'>
      <fieldset>
        <h1>Eintrag editieren</h1>
        <table>
          <tr>
            <td class="bold">Titel:</td>
            <td><g:textField class="text" name="title" id="title" value="${postInstance.title}"/></td>
          </tr>
          <tr>
            <td class="bold vtop">Teaser:</td>
            <td><g:textArea name="teaser" rows="3" cols="100">${postInstance.teaser}</g:textArea></td>
          </tr>
          <tr>
            <td class="bold vtop">Inhalt:</td>
            <td><fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                <fckeditor:editor name="content" id="content" width="100%" height="400" toolbar="Post" fileBrowser="default">
                  ${postInstance.content}
                </fckeditor:editor></td>
          </tr>
        </table>

        <div class="buttonbar">
          <g:submitButton name="submit" id="update" value="Aktualisieren"/>
          <g:link action="index">Abbrechen</g:link>
        </div>
      </fieldset>
      <br/>
    </g:form>
  </body>
</html>