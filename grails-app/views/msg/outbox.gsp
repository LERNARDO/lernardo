<head>
  <title>Lernardo | Postausgang</title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="headerBlue">
  <h1>Postfach: Postausgang</h1>
</div>
<div class="boxGray">
    <div id="inbox">
      <div class="buttons">
        <g:link class="buttonBlue" controller="msg" action="inbox" params="[name:entity.name]">Posteingang</g:link>
        <g:link class="buttonBlue" controller="msg" action="outbox" params="[name:entity.name]">Postausgang</g:link>
        <div class="spacer"></div>
      </div>

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
          <p>Du hast derzeit keine Nachrichten in deinem Postausgang!</p>
        </div>
        </g:if>
        <g:each in="${msgInstanceList}" status="i" var="msgInstance">
        <tr>
          <td class="profile-pic">
          <g:link controller="profile" action="showProfile" params="[name:msgInstance.receiver.name]">
            <ub:profileImage name="${msgInstance.receiver.name}" width="50" height="50" align="left"/>
          </g:link>
          </td>
          <td class="name-date">
            <span class="name">an <g:link controller="profile" action="showProfile" params="[name:msgInstance.receiver.name]">${msgInstance.receiver.profile.fullName}</g:link></span>
            <span class="date"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}"/></span>
          </td>
          <td class="subject">
            <span class="subject-text"><g:link action="show" id="${msgInstance.id}" params="[name:entity.name,box:'outbox']">${msgInstance.subject}</g:link></span>
          </td>
          <td class="delete-msg"><g:link class="buttonBlue" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${msgInstance.id}" params="[name:entity.name,box:'outbox']">Löschen</g:link></td>
        </tr>
        </g:each>

      </table>

      <div class="paginateButtons">
        <g:paginate total="${msgInstanceTotal}"/>
      </div>

    </div>
</div>
</body>