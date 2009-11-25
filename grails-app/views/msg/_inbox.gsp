<head>
  <g:javascript library="jquery"/>
</head>
  <h1>Posteingang</h1>
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
            <p>Keine Nachrichten im Posteingang vorhanden!</p>
          </div>
        </g:if>
        <g:each in="${msgInstanceList}" status="i" var="msgInstance">
        <tr class="<g:if test="${!msgInstance.read}">msg-unread</g:if>">
          %{--<td class="checkbox-toggle">--}%
            %{--<input type="checkbox" onclick=""/>--}%
          %{--</td>--}%
          <td class="profile-pic">
          <g:link controller="post" action="profile" params="[name:msgInstance.sender.name]">
            <ub:profileImage name="${msgInstance.sender.name}" width="50" height="50" align="left"/>
          </g:link>
          </td>
          <td class="name-date">
          <g:if test="${!msgInstance.read}">
            <span class="state">
                Neue Nachricht
            %{--
              <g:else>
                (GELESEN)
              </g:else>
            --}%
            </span>
            </g:if>
            <span class="name">von <g:link controller="post" action="profile" params="[name:msgInstance.sender.name]">${msgInstance.sender.profile.fullName}</g:link>
            <span class="date"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}"/></span>
          </td>
          <td class="subject">
            <span class="subject-text"><g:link action="show" id="${msgInstance.id}">${msgInstance.subject}</g:link></span>
          </td>
          <td class="delete-msg"><g:link action="delete" id="${msgInstance.id}">Löschen</g:link></td>
        </tr>
        </g:each>

      </table>
      <div id="inbox-footer">
        <div class="paginateButtons">
          <g:paginate total="${msgInstanceTotal}"/>
        </div>
      </div>
    </div>