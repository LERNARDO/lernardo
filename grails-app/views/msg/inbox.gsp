<head>
  <title>Lernardo | Posteingang</title>
  <meta name="layout" content="private"/>
</head>
<body>
<div class="headerBlue">
  <h1>Postfach: Posteingang</h1>
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
            <p>Keine Nachrichten im Posteingang vorhanden!</p>
          </div>
        </g:if>
        <g:each in="${msgInstanceList}" status="i" var="msgInstance">
        <tr class="<g:if test="${!msgInstance.read}">msg-unread</g:if>">
          %{--<td class="checkbox-toggle">--}%
            %{--<input type="checkbox" onclick=""/>--}%
          %{--</td>--}%
          <td class="profile-pic">
          <app:isEnabled entityName="${msgInstance.sender.name}">
            <g:link controller="profile" action="showProfile" params="[name:msgInstance.sender.name]">
              <ub:profileImage name="${msgInstance.sender.name}" width="50" height="50" align="left"/>
            </g:link>
          </app:isEnabled>
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
            <span class="name">von
              <app:isEnabled entityName="${msgInstance.sender.name}">
                <g:link controller="profile" action="showProfile" params="[name:msgInstance.sender.name]">${msgInstance.sender.profile.fullName}</g:link>
              </app:isEnabled>
              <app:notEnabled entityName="${msgInstance.sender.name}">
                <span class="notEnabled">${msgInstance.sender.profile.fullName}</span>
              </app:notEnabled>
              </span>
            <span class="date"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}"/></span>
          </td>
          <td class="subject">
            <span class="subject-text"><g:link action="show" id="${msgInstance.id}" params="[name:entity.name,box:'inbox']">${msgInstance.subject}</g:link></span>
          </td>
          <td class="delete-msg"><g:link class="buttonBlue" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${msgInstance.id}" params="[name:entity.name,box:'inbox']">Löschen</g:link></td>
        </tr>
        </g:each>

      </table>

      <div class="paginateButtons">
        <g:paginate total="${msgInstanceTotal}"/>
      </div>

    </div>
</div>
</body>