<head>
  <title>Nachricht senden</title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Nachricht senden</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${msgInstance}">
      <div class="errors">
        <g:renderErrors bean="${msgInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post" params="[entity:receiver.id]" id="${msgInstance.id}">
      <table id="msg-composer">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="entity">
              <g:message code="msg.entity.label" default="An"/>:
            </label>
          </td>
          <td valign="top" class="value">
            <span id="entity" class="bold">${receiver.profile.fullName}</span>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="subject">
              <g:message code="msg.subject.label" default="Betreff"/>:
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: msgInstance, field: 'subject', 'errors')}" size="70" id="subject" name="subject" value="${fieldValue(bean: msgInstance, field: 'subject')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="content">
              <g:message code="msg.content.label" default="Nachricht"/>:
            </label>
          </td>
          <td valign="top" class="value">
            <g:textArea class="countable2000 ${hasErrors(bean: msgInstance, field: 'content', 'errors')}" rows="10" cols="70" id="content" name="content" value="${fieldValue(bean: msgInstance, field: 'content')}"/>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>

            <div class="buttons">
              <g:submitButton name="submitButton" value="Senden"/>
              <g:link class="buttonGray" controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">Abbrechen</g:link>
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