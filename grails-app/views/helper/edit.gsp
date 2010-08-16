<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Hilfethema bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Hilfethema bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${helperInstance}">
      <div class="errors">
        <g:renderErrors bean="${helperInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${helperInstance?.id}" params="[name:entity.id]">
      <table>
        <tbody>

        <tr>
          <td class="label">Titel:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'title', 'errors')}"><g:textField class="countable${helperInstance.constraints.title.maxSize}" name="title" size="70" value="${fieldValue(bean:helperInstance, field:'title').decodeHTML()}"/></td>
        </tr>

        <tr>
          <td class="label">Inhalt:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'content', 'errors')}">
            <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
            <fckeditor:editor name="content" id="content" width="680" height="300" toolbar="Post" fileBrowser="default">
              ${helperInstance.content}
            </fckeditor:editor>
          </td>
        </tr>

        <tr>
          <td class="label">Für:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'type', 'errors')}"><g:select id="type" name="type" from="${[Educator:'Pädagogen',User:'Moderatoren']}" value="${fieldValue(bean:helperInstance, field:'type')}" optionKey="key" optionValue="value"/></td>
        </tr>

        </tbody>
      </table>

      <div class="buttons">
        <g:submitButton name="submitButton" value="Speichern"/>
        <g:link class="buttonGreen" action="del" id="${helperInstance.id}" params="[entity:entity.id]" onclick="return confirm('${message(code:'delete.warn')}');">Löschen</g:link>
        <g:link class="buttonGray" action="list" id="${entity.id}">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
