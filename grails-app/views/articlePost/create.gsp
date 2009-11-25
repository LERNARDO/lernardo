<head>
  <title>News</title>
  <meta name="layout" content="public"/>
  <g:javascript library="jquery"/>
</head>

<body>
<div class="body">
  <a name="anker"></a>
  <h1>Artikel verfassen</h1>
  <g:hasErrors bean="${postInstance}">
    <div id="flash-msg">
      <div class="errors">
        <g:renderErrors bean="${postInstance}" as="list"/>
      </div>
    </div>
  </g:hasErrors>
  <g:form action="saveArticle" method="post" id="${postInstance.id}">
    <table id="msg-composer">
      <tbody>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="title">
            <g:message code="msg.title.label" default="Titel"/>:
          </label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'title', 'errors')}">
          <input type="text" size="70" id="title" name="title" value="${fieldValue(bean: postInstance, field: 'title')}"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="teaser">
            <g:message code="msg.teaser.label" default="Teaser"/>:
          </label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'teaser', 'errors')}">
          <textarea rows="5" cols="100" id="teaser" name="teaser">${fieldValue(bean: postInstance, field: 'teaser')}</textarea>
        </td>
      </tr>
      <tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="content">
            <g:message code="msg.content.label" default="Inhalt"/>:
          </label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: postInstance, field: 'content', 'errors')}">
          <textarea rows="10" cols="100" id="content" name="content">${fieldValue(bean: postInstance, field: 'content')}</textarea>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>
          <div class="buttons">
            <span class="button"><g:actionSubmit class="save" action="save" value="Hinzufügen"/></span>
            <g:link action="index">zurück</g:link>
          </div>
        </td>
      </tr>
      </tbody>
    </table>
  </g:form>
</div>
</body>