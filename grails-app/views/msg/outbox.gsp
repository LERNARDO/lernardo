<head>
  <title><g:message code="msg.outbox"/></title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="msg.outbox"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div id="inbox">

      %{--<div id="inbox-actions">
      <div id="inbox-action-form">
      <form action="#" name="inbox-action-form">
        Auswählen:
        <select name="msg-select">
          <option value="none">----</option>
          <option value="read">Gelesen</option>
          <option value="unread">Ungelesen</option>
          <option value="all">Alle</option>
        </select>
        <select name="msg-actions">
          <option value="markasread">Als gelesen markieren</option>
          <option value="markasunread">Als ungelesen markieren</option>
          <option value="delete">Löschen</option>
        </select>
      </form>
      </div>
      <div id="inbox-refresh"><a href="#">Aktualisieren</a></div>
      </div>--}%
      <table id="inbox-message-overview" class="message-rows">

        <g:if test="${msgInstanceList.size() == 0}">
          <div class="info-msg-postbox">
            <g:message code="msg.outbox.emptyMsg"/>
          </div>
        </g:if>
        <g:each in="${msgInstanceList}" status="i" var="msgInstance">
          <tr>
            <td class="profile-pic">
              <g:link controller="${msgInstance.receiver.type.supertype.name +'Profile'}" action="show" id="${msgInstance.receiver.id}" params="[entity:msgInstance.receiver.id]">
                <ub:profileImage name="${msgInstance.receiver.name}" width="50" height="50" align="left"/>
              </g:link>
            </td>
            <td class="name-date">
              <span class="name">an <g:link controller="${msgInstance.receiver.type.supertype.name +'Profile'}" action="show" id="${msgInstance.receiver.id}" params="[entity:msgInstance.receiver.id]">${msgInstance.receiver.profile.fullName}</g:link></span>
              <span class="date"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}"/></span>
            </td>
            <td class="subject">
              <span class="subject-text"><g:link action="show" id="${msgInstance.id}" params="[entity:entity.id,box:'outbox']">${msgInstance.subject.decodeHTML()}</g:link></span>
            </td>
            <td class="delete-msg"><g:link class="buttonGreen" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${msgInstance.id}" params="[entity:entity.id,box:'outbox']"><g:message code="delete"/></g:link></td>
          </tr>
        </g:each>

      </table>

      <g:if test="${msgInstanceTotal > 0}">
        <div class="paginateButtons">
          <g:paginate total="${msgInstanceTotal}"/>
        </div>
      </g:if>

      <div class="buttons">
        <g:link class="buttonGreen" controller="msg" action="inbox" id="${entity.id}"><g:message code="msg.outbox.toOutbox"/></g:link>
        %{--<g:link class="buttonBlue" controller="msg" action="outbox" id="${entity.id}">Postausgang</g:link>--}%
        <div class="spacer"></div>
      </div>

    </div>
  </div>
</div>
</body>