<head>
  <title><g:message code="msg.inbox"/></title>
  <meta name="layout" content="private"/>
</head>
<body>
<g:if test="${currentEntity.profile.showTips}">
  <div class="toolTip" id="tooltip">
    <div class="second">
      <span class="bold"><img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><g:message code="hint"/></span> <g:message code="tooltip.inbox"/>
      <span style="float: right"><a onclick="toggle('#tooltip'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'cross.png')}" alt="Close"/></a></span>
    </div>
  </div>
</g:if>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="msg.inbox"/></h1>
  </div>
</div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="msg" action="outbox" id="${entity.id}"><g:message code="msg.outbox"/></g:link></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="buttons">
      <g:link class="buttonGreen" controller="msg" action="createMany" id="${entity.id}"><g:message code="msg.create"/></g:link>
      <div class="spacer"></div>
    </div>

    <g:if test="${messages.size() == 0}">
      <div class="info-msg">
        <g:message code="msg.inbox.emptyMsg"/>
      </div>
    </g:if>
    <g:each in="${messages}" status="i" var="message">
      <div class="messagebox" style="${!message.read ? 'background: #fdd; border: 1px solid #dbb' : ''}">
        <table>
          <tr>
            <td style="padding-right: 10px;">
              <erp:isEnabled entity="${message.sender}">
                <g:link controller="${message.sender.type.supertype.name +'Profile'}" action="show" id="${message.sender.id}"  params="[entity:message.sender.id]">
                  <erp:profileImage entity="${message.sender}" width="50" height="50" align="left"/>
                </g:link>
              </erp:isEnabled>
            </td>
            <td style="padding-right: 10px;">
              <g:if test="${!message.read}"><div class="new"><g:message code="msg.inbox.newMsg"/></div></g:if>
              <div class="name">
                <span class="bold"><g:message code="msg.from"/>:</span>
                <erp:isEnabled entity="${message.sender}">
                  <g:link controller="${message.sender.type.supertype.name +'Profile'}" action="show" id="${message.sender.id}" params="[entity:message.sender.id]">${message.sender.profile.fullName}</g:link>
                </erp:isEnabled>
                <erp:notEnabled entity="${message.sender}">
                  <span class="notEnabled">${message.sender.profile.fullName}</span>
                </erp:notEnabled>
              </div>
              <div class="date"><span class="bold"><g:message code="date"/>:</span> <g:formatDate format="dd.MM.yyyy, HH:mm" date="${message.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></div>
            </td>
            <td>
              <div class="subject-text"><span class="bold"><g:message code="msg.subject"/>:</span> ${message.subject.decodeHTML()}</div>
              <g:link class="buttonGreen" action="show" id="${message.id}" params="[entity:entity.id,box:'inbox']"><g:message code="msg.show"/></g:link>
              <g:link class="buttonRed" action="del" onclick="return confirm('Nachricht wirklich löschen?');" id="${message.id}" params="[entity:entity.id,box:'outbox']"><g:message code="delete"/></g:link></td>
          </tr>
        </table>
      </div>
    </g:each>

    <g:if test="${messages.totalCount > 0}">
      <div class="paginateButtons">
        <g:paginate total="${messages.totalCount}"/>
      </div>
    </g:if>

  </div>
</div>
</body>