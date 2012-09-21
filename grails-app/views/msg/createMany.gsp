<head>
  <title><g:message code="privat.msgCreate"/></title>
  <meta name="layout" content="database"/>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="privat.msgCreate"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: mc]"/>

    <g:form action="saveMany" id="${msgInstance?.id}" params="[entity: entity.id]">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="msg.to"/>:</td>
          <td valign="top" class="value">
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
          <td valign="top" class="name"><g:message code="msg.subject"/>:</td>
          <td valign="top" class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: mc, field: 'subject', 'errors')}" size="50" name="subject" value="${fieldValue(bean: mc, field: 'subject').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content"/>:</td>
          <td valign="top" class="value">
            <ckeditor:editor name="content" height="200px" toolbar="Basic">
              ${fieldValue(bean:mc,field:'content').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code: 'send')}"/></div>
        <g:link class="buttonGray" controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]"><g:message code="cancel"/></g:link>
      </div>

    </g:form>
  </div>
</div>
</body>