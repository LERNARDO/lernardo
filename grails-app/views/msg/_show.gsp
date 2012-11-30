<h4><g:message code="msg"/></h4>

<div class="boxContent">

    <table class="private-msg" style="width: 100%">
      <tbody>

      <tr class="prop">
        <td valign="top" class="value title">${fieldValue(bean: msgInstance, field: 'subject').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="value name"><g:link controller="${msgInstance.sender.type.supertype.name + 'Profile'}" action="show" id="${msgInstance.sender.id}">${msgInstance.sender.profile.decodeHTML()}</g:link> <g:message code="for"/> <g:each in="${msgInstance.receivers}" var="receiver"><g:link controller="${receiver.type.supertype.name + 'Profile'}" action="show" id="${receiver.id}">${receiver.profile.decodeHTML()}</g:link>, </g:each> <span style="float: right"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></span></td>
      </tr>

      <tr class="prop">
        <td valign="top" class="value content">${fieldValue(bean: msgInstance, field: 'content').decodeHTML()}</td>
      </tr>

      </tbody>
    </table>

    <div class="buttons cleared">
      %{--reply is only possible when sender account is enabled--}%
      <erp:isEnabled entity="${msgInstance.sender}">
        <g:remoteLink update="content" class="buttonGreen" controller="msg" action="createMany" id="${msgInstance.sender.id}" params="[original: msgInstance.id, entity:entity.id, subject:'AW: '+msgInstance.subject.encodeAsHTML(), reply: 'true']" before="showspinner('#content');"><g:message code="reply"/></g:remoteLink>
      </erp:isEnabled>
      <g:remoteLink update="content" class="buttonRed" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${msgInstance.id}" params="[entity:entity.id,box:box]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><g:message code="delete"/></g:remoteLink>
      <g:remoteLink update="content" class="buttonGray" action="${box}" id="${entity.id}" before="showspinner('#content');"><g:message code="back"/></g:remoteLink>
    </div>

</div>