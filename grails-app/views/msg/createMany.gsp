<head>
  <title><g:message code="privat.msgCreate"/></title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="privat.msgCreate"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: msgInstance]"/>

    <g:form action="saveMany" id="${msgInstance.id}">
      <table width="100%">

        <tr class="prop">
          <td valign="top" class="name"><g:message code="msg.to"/>:</td>
          <td valign="top" class="value">
            <div style="border-bottom: 1px solid #ccc; margin-bottom: 10px; padding-bottom: 5px">

              <g:remoteField size="40" name="remoteField" update="remoteReceivers" action="remoteReceivers" before="showspinner('#remoteReceivers')"/>
              <div id="remoteReceivers"></div>

              <div style="visibility: hidden">
                <select name="receivers" id="hiddenselect" multiple="true" value="default"></select>
              </div>

              <span class="bold">Gewählte Empfänger:</span>
              <div id="receivers2">
              </div>
            </div>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="msg.subject"/>:</td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: msgInstance, field: 'subject', 'errors')}" size="50" name="subject" value="${fieldValue(bean: msgInstance, field: 'subject').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="msg.content"/>:</td>
          <td valign="top" class="value">
            <ckeditor:editor name="content" height="200px" toolbar="Basic">
              ${fieldValue(bean:msgInstance,field:'content').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

      </table>

      <div class="buttons">
        <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="Senden"/></div>
        <g:link class="buttonGray" controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>