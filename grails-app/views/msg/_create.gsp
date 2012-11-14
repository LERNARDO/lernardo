<h4><g:message code="privat.msgCreate"/></h4>

<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: msgInstance]"/>

    <g:form action="save" params="[receiver: receiver.id, reply: reply, entity: entity.id]" id="${msgInstance.id}">
      <table width="100%">
        <tbody>

        <tr class="prop">
          <td class="name"><g:message code="msg.to"/>:</td>
          <td class="value"><span class="bold">${receiver.profile.decodeHTML()}</span></td>
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
              <g:textArea name="content" rows="10" cols="50"/>
          </td>
        </tr>

        </tbody>
      </table>

      <div class="buttons cleared">
        <div class="button"><g:submitButton name="submitButton" class="buttonGreen" value="${message(code: 'send')}" onclick="parent.frames[0].CK.UpdateLinkedField();" /></div>
        <g:remoteLink update="content" class="buttonGray" controller="msg" action="outbox" id="${entity.id}" before="showspinner('#content');"><g:message code="cancel"/></g:remoteLink>
      </div>

    </g:form>

</div>