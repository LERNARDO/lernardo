<h4><g:message code="privat.msgCreate"/></h4>

<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: mc]"/>

    <g:formRemote name="formRemote" url="[controller: 'msg', action: 'saveMany', id: msgInstance.id, params: [entity: entity.id]]" update="content">
    %{--<g:form action="saveMany" id="${msgInstance?.id}" params="[entity: entity.id]">--}%

      <table>

        <tr class="prop">
          <td class="name"><g:message code="msg.to"/>:</td>
          <td class="value">
            <div style="border-bottom: 1px solid #ccc; margin-bottom: 10px; padding-bottom: 5px">

              <g:remoteField class="${hasErrors(bean: mc, field: 'receivers', 'errors')}" size="40" name="remoteField" update="remoteReceivers" action="remoteReceivers" before="showspinner('#remoteReceivers')"/>
              <div id="remoteReceivers"></div>

              <div style="">
                <p class="bold"><g:message code="chosenRecipients"/></p>
                <g:select name="receivers" id="hiddenselect" multiple="true" value="default" from="${receivers}" optionKey="id" optionValue="profile"/>
                <script type="text/javascript">
                  var select = document.getElementById("hiddenselect");
                  for (var i = 0; i < select.options.length; i++) {
                    select.options[i].selected = true
                  }
                </script>
              </div>

            </div>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="msg.subject"/>:</td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: mc, field: 'subject', 'errors')}" size="50" name="subject" value="${fieldValue(bean: mc, field: 'subject').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="content"/>:</td>
          <td class="value">
              <g:textArea name="content" rows="10" cols="50"/>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code: 'send')}" onclick="parent.frames[0].FCK.UpdateLinkedField();" /></div>
        <g:remoteLink update="content" class="buttonGray" controller="msg" action="inbox" id="${entity.id}" before="showspinner('#content');"><g:message code="cancel"/></g:remoteLink>
      </div>

    </g:formRemote>

</div>