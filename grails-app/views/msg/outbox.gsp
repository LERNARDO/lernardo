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
    <div id="inbox">

      <table id="inbox-message-overview" class="message-rows">

        <g:if test="${messages.size() == 0}">
          <div class="info-msg">
            <g:message code="msg.outbox.emptyMsg"/>
          </div>
        </g:if>
        <g:each in="${messages}" status="i" var="message">
          <tr>
            <td class="profile-pic">
              <g:link controller="${message.receiver.type.supertype.name +'Profile'}" action="show" id="${message.receiver.id}" params="[entity:message.receiver.id]">
                <ub:profileImage name="${message.receiver.name}" width="50" height="50" align="left"/>
              </g:link>
            </td>
            <td class="name-date">
              <span class="name">an <g:link controller="${message.receiver.type.supertype.name +'Profile'}" action="show" id="${message.receiver.id}" params="[entity:message.receiver.id]">${message.receiver.profile.fullName}</g:link></span>
              <span class="date"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${message.dateCreated}"/></span>
            </td>
            <td class="subject">
              <span class="subject-text"><g:link action="show" id="${message.id}" params="[entity:entity.id,box:'outbox']">${message.subject.decodeHTML()}</g:link></span>
            </td>
            <td class="delete-msg"><g:link class="buttonGreen" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${message.id}" params="[entity:entity.id,box:'outbox']"><g:message code="delete"/></g:link></td>
          </tr>
        </g:each>

      </table>

      <g:if test="${messages.totalCount > 0}">
        <div class="paginateButtons">
          <g:paginate total="${messages.totalCount}"/>
        </div>
      </g:if>

      <div class="buttons">
        <g:link class="buttonGreen" controller="msg" action="inbox" id="${entity.id}"><g:message code="msg.outbox.toOutbox"/></g:link>
        <div class="spacer"></div>
      </div>

    </div>
  </div>
</div>
</body>