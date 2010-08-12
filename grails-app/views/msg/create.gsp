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

    <g:render template="/templates/errors" model="[bean: msgInstance]"/>

    <g:form action="save" method="post" params="[entity:receiver.id]" id="${msgInstance.id}">
      <table id="msg-composer">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="msg.entity.label" default="An"/>:</td>
          <td valign="top" class="value"><span class="bold">${receiver.profile.fullName.decodeHTML()}</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="msg.subject.label" default="Betreff"/>:</td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: msgInstance, field: 'subject', 'errors')}" size="70" name="subject" value="${fieldValue(bean: msgInstance, field: 'subject').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="msg.content.label" default="Nachricht"/>:</td>
          <td valign="top" class="value">
            <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
            <fckeditor:editor name="content" height="200" width="700" toolbar="Basic" fileBrowser="default">
              ${fieldValue(bean:msgInstance,field:'content').decodeHTML()}
            </fckeditor:editor>
            %{--<g:textArea class="countable2000 ${hasErrors(bean: msgInstance, field: 'content', 'errors')}" rows="10" cols="70" name="content" value="${fieldValue(bean: msgInstance, field: 'content')}"/>--}%
          </td>
        </tr>

        </tbody>
      </table>

      <div class="buttons">
        <g:submitButton name="submitButton" value="Senden"/>
        <g:link class="buttonGray" controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>