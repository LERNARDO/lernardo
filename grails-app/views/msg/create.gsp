<head>
  <title><g:message code="privat.msgCreate"/></title>
  <meta name="layout" content="database"/>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="privat.msgCreate"/></h1>
</div>
<div class="boxGray">

    <g:render template="/templates/errors" model="[bean: msgInstance]"/>

    <g:form action="save" params="[receiver: receiver.id, reply: reply, entity: entity.id]" id="${msgInstance.id}">
      <table width="100%">
        <tbody>

        <tr class="prop">
          <td class="name"><g:message code="msg.to"/>:</td>
          <td class="value"><span class="bold">${receiver.profile.fullName.decodeHTML()}</span></td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="msg.subject"/>:</td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: msgInstance, field: 'subject', 'errors')}" size="50" name="subject" value="${fieldValue(bean: msgInstance, field: 'subject').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="content"/>:</td>
          <td class="value">
            <ckeditor:editor name="content" height="200px" toolbar="Basic">
              ${fieldValue(bean:msgInstance,field:'content').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        </tbody>
      </table>

      <div class="buttons cleared">
        <div class="button"><g:submitButton name="submitButton" class="buttonGreen" value="${message(code: 'send')}"/></div>
        <g:link class="buttonGray" controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]"><g:message code="cancel"/></g:link>
      </div>

    </g:form>

</div>
</body>