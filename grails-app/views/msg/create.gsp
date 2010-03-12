<head>
  <title>Lernardo | Nachricht senden</title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="headerBlue">
  <h1>Nachricht senden</h1>
</div>
<div class="boxGray">
  <div class="body">
    <g:hasErrors bean="${msgInstance}">
      <div id="flash-msg">
        <div class="errors">
          <g:renderErrors bean="${msgInstance}" as="list"/>
        </div>
      </div>
    </g:hasErrors>
    <g:form action="save" method="post" params="[entity:entity.id]" id="${msgInstance.id}">
      <table id="msg-composer">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="entity">
              <g:message code="msg.entity.label" default="An"/>:
            </label>
          </td>
          <td valign="top" class="value">
            <span id="entity" class="bold">${entity.profile.fullName}</span>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="subject">
              <g:message code="msg.subject.label" default="Betreff"/>:
            </label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: msgInstance, field: 'subject', 'errors')}">
            <input type="text" size="70" id="subject" name="subject" value="${fieldValue(bean: msgInstance, field: 'subject')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="content">
              <g:message code="msg.content.label" default="Nachricht"/>:
            </label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: msgInstance, field: 'content', 'errors')}">
            <textarea rows="10" cols="70" id="content" name="content">${fieldValue(bean: msgInstance, field: 'content')}</textarea>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>

            <div class="buttons">
              <g:submitButton name="submitButton" value="Senden"/>
              <g:link class="buttonGray" controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}">Abbrechen</g:link>
              <div class="spacer"></div>
            </div>

          </td>
        </tr>
        </tbody>
      </table>
    </g:form>
  </div>
</div>
</body>