<head>
  <title><g:message code="msg.outbox"/></title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="msg.outbox"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="buttons">
      <g:link class="buttonGreen" controller="msg" action="inbox" id="${entity.id}"><g:message code="msg.outbox.toOutbox"/></g:link>
      <div class="spacer"></div>
    </div>

      <g:if test="${messages.size() == 0}">
        <div class="info-msg">
          <g:message code="msg.outbox.emptyMsg"/>
        </div>
      </g:if>
      <g:each in="${messages}" status="i" var="message">
        <div class="messagebox">
          <table>
            <tr>
              <td style="padding-right: 10px;">
                <g:link controller="${message.receiver.type.supertype.name +'Profile'}" action="show" id="${message.receiver.id}" params="[entity:message.receiver.id]">
                  <ub:profileImage name="${message.receiver.name}" width="50" height="50" align="left"/>
                </g:link>
              </td>
              <td style="padding-right: 10px;">
                <div class="name"><span class="bold"><g:message code="msg.to"/>:</span> <g:link controller="${message.receiver.type.supertype.name +'Profile'}" action="show" id="${message.receiver.id}" params="[entity:message.receiver.id]">${message.receiver.profile.fullName}</g:link></div>
                <div class="date"><span class="bold"><g:message code="date"/>:</span> <g:formatDate format="dd.MM.yyyy, HH:mm" date="${message.dateCreated}"/></div>
              </td>
              <td>
                <div class="subject-text"><span class="bold"><g:message code="msg.subject"/>:</span> ${message.subject.decodeHTML()}</div>
                <g:link class="buttonGreen" action="show" id="${message.id}" params="[entity:entity.id,box:'outbox']"><g:message code="msg.show"/></g:link>
                <g:link class="buttonRed" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${message.id}" params="[entity:entity.id,box:'outbox']"><g:message code="delete"/></g:link></td>
            </tr>
          </table>
        </div>
      </g:each>

    <g:if test="${messages.totalCount > 0}">
      <div class="paginateButtons">
        <g:paginate total="${messages.totalCount}"/>
      </div>
    </g:if>

  </div>
</div>
</body>