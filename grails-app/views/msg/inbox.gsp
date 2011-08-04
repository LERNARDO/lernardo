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

    <g:if test="${totalMessages == 0}">
      <div class="info-msg">
        <g:message code="msg.inbox.emptyMsg"/>
      </div>
    </g:if>
    <g:else>
      <table class="default-table">
        <thead>
          <tr>
            <g:sortableColumn property="sender" title="${message(code:'msg.from')}"/>
            <g:sortableColumn property="subject" title="${message(code:'msg.subject')}"/>
            <g:sortableColumn property="dateCreated" title="${message(code:'date')}"/>
          </tr>
        </thead>
        <tbody>
          <g:each in="${messages}" status="i" var="message">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}" style="${!message.read ? 'background: #dfd' : ''}">
              <td><g:if test="${!message.read}"><img src="${g.resource(dir: 'images/icons', file: 'icon_new.png')}" alt="new" valign="top"/></g:if> ${message.sender.profile.fullName.decodeHTML()}</td>
              <td><g:link action="show" id="${message.id}" params="[entity:entity.id,box:'inbox']">${message.subject.decodeHTML()}</g:link></td>
              <td><g:formatDate format="dd.MM.yyyy, HH:mm" date="${message.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
            </tr>
          </g:each>
        </tbody>
      </table>
    </g:else>

    <g:if test="${totalMessages > 0}">
      <div class="paginateButtons">
        <g:paginate total="${totalMessages}" id="${entity.id}"/>
      </div>
    </g:if>

  </div>
</div>
</body>