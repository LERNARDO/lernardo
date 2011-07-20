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
    <g:else>
      <table class="default-table">
        <thead>
          <tr>
            <g:sortableColumn property="receiver" title="${message(code:'msg.to')}"/>
            <g:sortableColumn property="subject" title="${message(code:'msg.subject')}"/>
            <g:sortableColumn property="dateCreated" title="${message(code:'date')}"/>
          </tr>
        </thead>
        <tbody>
          <g:each in="${messages}" status="i" var="message">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td>${message.receiver.profile.fullName.decodeHTML()}</td>
              <td><g:link action="show" id="${message.id}" params="[entity:entity.id,box:'outbox']">${message.subject.decodeHTML()}</g:link></td>
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