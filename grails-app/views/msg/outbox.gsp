<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Profil von ${entity.profile.fullName}</title>
  <g:javascript library="jquery"/>
</head>
<body>
  <h1>Postausgang</h1>
    <div id="inbox">
      <div id="inbox-navigation">
        <div id="left-list">
          <ul class="tabs">
            <li><g:link controller="msg" action="inbox" params="[name:entity.name]">Posteingang</g:link></li>
            <li><g:link controller="msg" action="outbox" params="[name:entity.name]">Postausgang</g:link></li>
          </ul>
        </div>
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
          <p>Keine Nachrichten im Postausgang vorhanden!</p>
        </div>
        </g:if>
        <g:each in="${msgInstanceList}" status="i" var="msgInstance">
        <tr>
          <td class="profile-pic">
          <g:link controller="profile" action="showProfile" params="[name:msgInstance.receiver.name]">
            <ub:profileImage name="${msgInstance.receiver.name}" width="50" height="65" align="left"/>
          </g:link>
          </td>
          <td class="name-date">
            <span class="name">an <g:link controller="profile" action="showProfile" params="[name:msgInstance.receiver.name]">${msgInstance.receiver.profile.fullName}</g:link></span>
            <span class="date"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}"/></span>
          </td>
          <td class="subject">
            <span class="subject-text"><g:link action="show" id="${msgInstance.id}" params="[name:entity.name]">${msgInstance.subject}</g:link></span>
          </td>
          <td class="delete-msg"><g:link action="del" id="${msgInstance.id}" params="[name:entity.name]">Löschen</g:link></td>
        </tr>
        </g:each>

      </table>
      <div id="inbox-footer">
        <div class="paginateButtons">
          <g:paginate total="${msgInstanceTotal}"/>
        </div>
      </div>
    </div>
</body>