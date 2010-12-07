<head>
  <title><g:message code="msg.inbox"/></title>
  <meta name="layout" content="private"/>
</head>
<body>
<g:if test="${currentEntity.profile.showTips}">
  <div class="toolTip" id="tooltip">
    <div class="second">
      <span class="bold"><img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><g:message code="hint"/></span> <g:message code="msg.inbox.hint"/>
      <span style="float: right"><a onclick="toggle('#tooltip'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'cross.png')}" alt="Close"/></a></span>
    </div>
  </div>
</g:if>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="msg.inbox"/></h1>
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
            <g:message code="msg.inbox.emptyMsg"/>
          </div>
        </g:if>
        <g:each in="${msgInstanceList}" status="i" var="msgInstance">
          <tr class="<g:if test="${!msgInstance.read}">msg-unread</g:if>">
            %{--<td class="checkbox-toggle">--}%
            %{--<input type="checkbox" onclick=""/>--}%
            %{--</td>--}%
            <td class="profile-pic">
              <app:isEnabled entity="${msgInstance.sender}">
                <g:link controller="${msgInstance.sender.type.supertype.name +'Profile'}" action="show" id="${msgInstance.sender.id}"  params="[entity:msgInstance.sender.id]">
                  <ub:profileImage name="${msgInstance.sender.name}" width="50" height="50" align="left"/>
                </g:link>
              </app:isEnabled>
            </td>
            <td class="name-date">
              <g:if test="${!msgInstance.read}">
                <span class="state">
                  <g:message code="msg.inbox.newMsg"/>
                  %{--
                    <g:else>
                      (GELESEN)
                    </g:else>
                  --}%
                </span>
              </g:if>
              <span class="name">von
                <app:isEnabled entity="${msgInstance.sender}">
                  <g:link controller="${msgInstance.sender.type.supertype.name +'Profile'}" action="show" id="${msgInstance.sender.id}" params="[entity:msgInstance.sender.id]">${msgInstance.sender.profile.fullName}</g:link>
                </app:isEnabled>
                <app:notEnabled entity="${msgInstance.sender}">
                  <span class="notEnabled">${msgInstance.sender.profile.fullName}</span>
                </app:notEnabled>
              </span>
              <span class="date"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${msgInstance.dateCreated}"/></span>
            </td>
            <td class="subject">
              <span class="subject-text"><g:link action="show" id="${msgInstance.id}" params="[entity:entity.id,box:'inbox']">${msgInstance.subject.decodeHTML()}</g:link></span>
            </td>
            <td class="delete-msg"><g:link class="buttonGreen" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${msgInstance.id}" params="[entity:entity.id,box:'inbox']"><g:message code="delete"/></g:link></td>
          </tr>
        </g:each>

      </table>

      <g:if test="${msgInstanceTotal > 0}">
        <div class="paginateButtons">
          <g:paginate total="${msgInstanceTotal}"/>
        </div>
      </g:if>

      <div class="buttons">
        %{--<g:link class="buttonBlue" controller="msg" action="inbox" id="${entity.id}">Posteingang</g:link>--}%
        <g:link class="buttonGreen" controller="msg" action="outbox" id="${entity.id}"><g:message code="msg.inbox.toOutbox"/></g:link>
        <g:link class="buttonGreen" controller="msg" action="createMany" id="${entity.id}">Neue Nachricht verfassen</g:link>
        <div class="spacer"></div>
      </div>

    </div>
  </div>
</div>
</body>