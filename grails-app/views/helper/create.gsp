<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Hilfethema erstellen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Hilfethema erstellen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${helperInstance}">
      <div class="errors">
        <g:renderErrors bean="${helperInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post" params="[name:entity.name]">
      <table>
        <tbody>

        <tr>
          <td class="label">Titel:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'title', 'errors')}"><g:textField name="title" size="70" value="${fieldValue(bean:helperInstance, field:'title')}"/></td>
        </tr>

        <tr>
          <td class="label">Inhalt:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'content', 'errors')}">
            <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
            <fckeditor:editor name="content" id="content" width="500" height="300" toolbar="Post" fileBrowser="default">
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
        <g:link class="buttonGray" action="list" id="${entity.id}">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
