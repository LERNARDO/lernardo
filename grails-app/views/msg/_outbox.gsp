<head>
  <g:javascript library="jquery"/>
</head>
  <h1>Postausgang</h1>
    <div id="inbox">
      <div id="inbox-navigation">
        <div id="left-list">
          <ul class="tabs">
            <li><g:remoteLink controller="msg" action="inbox" update="profile-content">Posteingang</g:remoteLink></li>
            <li><g:remoteLink controller="msg" action="outbox" update="profile-content">Postausgang</g:remoteLink></li>
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
          <g:link controller="post" action="profile" params="[name:msgInstance.receiver.name]">
            <ub:profileImage name="${msgInstance.receiver.name}" width="50" height="65" align="left"/>
          </g:link>
          </td>
          <td class="name-date">
            <span class="name">an <g:link controller="profile" action="show" params="[name:msgInstance.receiver.name]">${msgInstance.receiver.profile.fullName}</g:link></span>
            <span class="date"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}"/></span>
          </td>
          <td class="subject">
            <span class="subject-text"><g:remoteLink action="show" update="profile-content" id="${msgInstance.id}" params="[name:entity.name]">${msgInstance.subject}</g:remoteLink></span>
          </td>
          <td class="delete-msg"><g:remoteLink action="delete" update="profile-content" id="${msgInstance.id}" params="[name:entity.name]">Löschen</g:remoteLink></td>
        </tr>
        </g:each>

      </table>
      <div id="inbox-footer">
        <div class="paginateButtons">
          <g:paginate total="${msgInstanceTotal}"/>
        </div>
      </div>
    </div>