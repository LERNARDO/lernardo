<head>
  <title>Nachricht</title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1>Mein Postfach: Nachricht</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <table class="form show-msg">
      <tbody>

      <tr class="prop">
        <td valign="top" class="value msg-title">${fieldValue(bean: msgInstance, field: 'subject').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="value msg-name">An <g:link controller="${msgInstance.receiver.type.supertype.name +'Profile'}" action="show" id="${msgInstance.receiver.id}">${msgInstance.receiver.profile.fullName.decodeHTML()}</g:link> am <g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
      </tr>

      <tr class="prop">
        <td valign="top" class="value msg-content">${fieldValue(bean: msgInstance, field: 'content').decodeHTML()}</td>
      </tr>

      </tbody>
    </table>

    <div class="buttons">
      %{--reply is only possible when sender account is enabled--}%
      <erp:isEnabled entity="${msgInstance.sender}">
        <g:link class="buttonGreen" controller="msg" action="create" id="${msgInstance.sender.id}" params="[entity:entity.id, subject:'AW: '+msgInstance.subject, reply: 'true']">Antworten</g:link>
      </erp:isEnabled>
      <g:link class="buttonRed" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${msgInstance.id}" params="[entity:entity.id,box:box]"><g:message code="delete"/></g:link>
      <g:link class="buttonGray" action="inbox" id="${entity.id}"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>