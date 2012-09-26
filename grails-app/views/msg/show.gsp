<head>
  <title><g:message code="msg"/></title>
  <meta name="layout" content="database"/>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="msg"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <table class="private-msg" style="width: 100%">
      <tbody>

      <tr class="prop">
        <td valign="top" class="value title">${fieldValue(bean: msgInstance, field: 'subject').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="value name"><g:link controller="${msgInstance.sender.type.supertype.name + 'Profile'}" action="show" id="${msgInstance.sender.id}">${msgInstance.sender.profile.fullName.decodeHTML()}</g:link> <g:message code="for"/> <g:link controller="${msgInstance.receiver.type.supertype.name + 'Profile'}" action="show" id="${msgInstance.receiver.id}">${msgInstance.receiver.profile.fullName.decodeHTML()}</g:link> <span style="float: right"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></span></td>
      </tr>

      <tr class="prop">
        <td valign="top" class="value content">${fieldValue(bean: msgInstance, field: 'content').decodeHTML()}</td>
      </tr>

      </tbody>
    </table>

    <div class="buttons cleared">
      %{--reply is only possible when sender account is enabled--}%
      <erp:isEnabled entity="${msgInstance.sender}">
        <g:link class="buttonGreen" controller="msg" action="create" id="${msgInstance.sender.id}" params="[entity:entity.id, subject:'AW: '+msgInstance.subject.encodeAsHTML(), reply: 'true']"><g:message code="reply"/></g:link>
      </erp:isEnabled>
      <g:link class="buttonRed" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${msgInstance.id}" params="[entity:entity.id,box:box]"><g:message code="delete"/></g:link>
      <g:link class="buttonGray" action="inbox" id="${entity.id}"><g:message code="back"/></g:link>
    </div>

  </div>
</div>
</body>