<head>
  <title><g:message code="msg.outbox"/></title>
  <meta name="layout" content="private"/>
</head>
<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="msg.inbox"/></g:link></h1>
  </div>
</div>
<div class="tabGreen">
  <div class="second">
    <h1><g:message code="msg.outbox"/></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

      <g:if test="${totalMessages == 0}">
        <div class="info-msg">
          <g:message code="msg.outbox.emptyMsg"/>
        </div>
      </g:if>
      <g:each in="${messages}" status="i" var="message">
        <div id="messagebox${i}">
          <div class="messagebox">
            <table>
              <tr>
                <td style="padding-right: 10px;">
                  <g:link controller="${message.receiver.type.supertype.name +'Profile'}" action="show" id="${message.receiver.id}" params="[entity:message.receiver.id]">
                    <erp:profileImage entity="${message.receiver}" width="50" height="50" align="left"/>
                  </g:link>
                </td>
                <td style="padding-right: 10px;">
                  <div class="name"><span class="bold"><g:message code="msg.to"/>:</span> <g:link controller="${message.receiver.type.supertype.name +'Profile'}" action="show" id="${message.receiver.id}" params="[entity:message.receiver.id]">${message.receiver.profile.fullName}</g:link></div>
                  <div class="date"><span class="bold"><g:message code="date"/>:</span> <g:formatDate format="dd.MM.yyyy, HH:mm" date="${message.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></div>
                </td>
                <td>
                  <div class="subject-text"><span class="bold"><g:message code="msg.subject"/>:</span> ${message.subject.decodeHTML()}</div>
                  <g:link class="buttonGreen" action="show" id="${message.id}" params="[entity:entity.id,box:'outbox']"><g:message code="msg.show"/></g:link>
                  %{--<g:link class="buttonRed" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${message.id}" params="[entity:entity.id,box:'outbox']"><g:message code="delete"/></g:link>--}%
                  <g:remoteLink class="buttonRed" action="del" update="messagebox${i}" id="${message.id}" before="if(!confirm('Nachricht wirklich löschen?')) return false"><g:message code="delete"/></g:remoteLink>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </g:each>

    <g:if test="${totalMessages > 0}">
      <div class="paginateButtons">
        <g:paginate total="${totalMessages}"/>
      </div>
    </g:if>

  </div>
</div>
</body>