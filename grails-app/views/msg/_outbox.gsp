<h4><g:remoteLink update="content" controller="msg" action="inbox" id="${entity.id}" before="showspinner('#content');"><g:message code="msg.inbox"/></g:remoteLink> - <g:message code="msg.outbox"/></h4>

<div class="boxContent">

    %{--<div class="buttons cleared">
      <g:link class="buttonGreen" controller="msg" action="inbox" id="${entity.id}"><g:message code="msg.inbox"/></g:link>
    </div>--}%

    <g:if test="${totalMessages == 0}">
      <div class="info-msg">
        <g:message code="msg.outbox.emptyMsg"/>
      </div>
    </g:if>
    <g:else>
      <table class="default-table">
        <thead>
          <tr>
            <g:sortableColumn property="subject" title="${message(code:'msg.subject')}"/>
            <g:sortableColumn property="receiver" title="${message(code:'msg.to')}"/>
            <g:sortableColumn property="dateCreated" title="${message(code:'date')}"/>
          </tr>
        </thead>
        <tbody>
          <g:each in="${messages}" status="i" var="message">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td><g:remoteLink update="content" action="show" id="${message.id}" params="[entity: entity.id, box: 'outbox']"  before="showspinner('#content');">${message.subject.decodeHTML()}</g:remoteLink></td>
                <td>
                <erp:profileImage entity="${message.receiver}" width="30" height="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
                ${message.receiver.profile.decodeHTML()}
              </td>
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