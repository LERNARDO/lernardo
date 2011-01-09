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
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="msg.inbox"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div id="inbox">

      <table id="inbox-message-overview" class="message-rows">

        <g:if test="${messages.size() == 0}">
          <div class="info-msg">
            <g:message code="msg.inbox.emptyMsg"/>
          </div>
        </g:if>
        <g:each in="${messages}" status="i" var="message">
          <tr class="<g:if test="${!message.read}">msg-unread</g:if>">
            %{--<td class="checkbox-toggle">--}%
            %{--<input type="checkbox" onclick=""/>--}%
            %{--</td>--}%
            <td class="profile-pic">
              <erp:isEnabled entity="${message.sender}">
                <g:link controller="${message.sender.type.supertype.name +'Profile'}" action="show" id="${message.sender.id}"  params="[entity:message.sender.id]">
                  <ub:profileImage name="${message.sender.name}" width="50" height="50" align="left"/>
                </g:link>
              </erp:isEnabled>
            </td>
            <td class="name-date">
              <g:if test="${!message.read}">
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
                <erp:isEnabled entity="${message.sender}">
                  <g:link controller="${message.sender.type.supertype.name +'Profile'}" action="show" id="${message.sender.id}" params="[entity:message.sender.id]">${message.sender.profile.fullName}</g:link>
                </erp:isEnabled>
                <erp:notEnabled entity="${message.sender}">
                  <span class="notEnabled">${message.sender.profile.fullName}</span>
                </erp:notEnabled>
              </span>
              <span class="date"><g:formatDate format="dd.MM.yyyy, HH:mm" date="${message.dateCreated}"/></span>
            </td>
            <td class="subject">
              <span class="subject-text"><g:link action="show" id="${message.id}" params="[entity:entity.id,box:'inbox']">${message.subject.decodeHTML()}</g:link></span>
            </td>
            <td class="delete-msg"><g:link class="buttonGreen" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${message.id}" params="[entity:entity.id,box:'inbox']"><g:message code="delete"/></g:link></td>
          </tr>
        </g:each>

      </table>

      <g:if test="${messages.totalCount > 0}">
        <div class="paginateButtons">
          <g:paginate total="${messages.totalCount}"/>
        </div>
      </g:if>

      <div class="buttons">
        <g:link class="buttonGreen" controller="msg" action="outbox" id="${entity.id}"><g:message code="msg.inbox.toOutbox"/></g:link>
        <g:link class="buttonGreen" controller="msg" action="createMany" id="${entity.id}">Neue Nachricht verfassen</g:link>
        <div class="spacer"></div>
      </div>

    </div>
  </div>
</div>
</body>