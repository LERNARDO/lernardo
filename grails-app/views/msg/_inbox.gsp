<h4><g:message code="msg.inbox"/> - <g:remoteLink update="content" controller="msg" action="outbox" id="${entity.id}" before="showspinner('#content');"><g:message code="msg.outbox"/></g:remoteLink></h4>

<div class="boxContent">

    <div class="buttons cleared">
      <g:remoteLink update="content" class="buttonGreen" controller="msg" action="createMany" id="${entity.id}" before="showspinner('#content');"><g:message code="msg.create"/></g:remoteLink>
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
              <td>
                <g:if test="${!message.read}">
                  <img src="${g.resource(dir: 'images/icons', file: 'icon_new.png')}" alt="new" valign="top"/>
                </g:if>
                <erp:profileImage entity="${message.sender}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
                ${message.sender.profile.decodeHTML()}
              </td>
              <td><g:remoteLink update="content" action="show" id="${message.id}" params="[entity: entity.id, box: 'inbox']"  before="showspinner('#content');">${message.subject.decodeHTML()}</g:remoteLink></td>
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