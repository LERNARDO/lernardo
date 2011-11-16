<%@ page import="at.openfactory.ep.Entity" %>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="events"/></title>
</head>

<body>

<div class="boxHeader">
  <div class="second">
    <h1><g:message code="events"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:if test="${events}">
      <table class="default-table">
        <tbody>
        <erp:getBirthdays>
          <g:if test="${entities}">
            <g:each in="${entities}" var="entity">
              <tr>
                <td class="gray">
                  <erp:profileImage entity="${entity}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/> <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]"><span class="bold">${entity.profile.fullName}</span></g:link> hat heute Geburtstag! <img src="${resource(dir: 'images/icons', file: 'icon_cake.png')}" alt="Birthday" style="position: relative; top: 3px; margin-right: 5px;"/><br/>
                </td>
              </tr>
            </g:each>
          </g:if>
        </erp:getBirthdays>
        <g:each in="${events}" status="i" var="event">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td class="gray">
              <erp:profileImage entity="${Entity.get(event.who)}" width="30" style="vertical-align: middle; margin: 0 10px 0 0;"/> <g:formatDate date="${event.date}" format="EE dd. MMM. yyyy - HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> - <erp:getEvent event="${event}"/> <erp:isSystemAdmin entity="${currentEntity}"><g:link action="delete" id="${event.id}" onclick="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="Birthday" style="position: relative; top: 3px; margin-right: 5px;"/></g:link></erp:isSystemAdmin>
            </td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate total="${totalEvents}"/>
      </div>
    </g:if>

    %{--<p><span class="strong"><g:message code="tomorrow"/></span></p>
    <p>
      <g:if test="${eventsTomorrow}">
        <g:each in="${eventsTomorrow}" var="event" status="i">
          <g:formatDate date="${event.date}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> - <erp:getEvent event="${event}"/><br/>
        </g:each>
      </g:if>
      <g:else>
        <span class="italic"><g:message code="profile.showNews.tomorrowMsg"/></span>
      </g:else>
    </p>
    <div class="cleartop"></div>

    <p><span class="strong"><g:message code="today"/> (<g:formatDate date="${Calendar.getInstance().time}" format="dd.MM.yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>)</span></p>

    <erp:getBirthdays>
      <g:if test="${entities}">
        <p>
          <g:each in="${entities}" var="entity">
            <img src="${resource(dir: 'images/icons', file: 'icon_cake.png')}" alt="${message(code:'birthday')}" valign="top"/> <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link> hat heute Geburtstag!<br/>
          </g:each>
        </p>
      </g:if>
    </erp:getBirthdays>

    <p>
      <g:if test="${eventsToday}">
        <g:each in="${eventsToday}" var="event" status="i">
          <g:formatDate date="${event.date}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> - <erp:getEvent event="${event}"/><br/>
        </g:each>
      </g:if>
      <g:else>
        <span class="italic"><g:message code="profile.showNews.todayMsg"/></span>
      </g:else>
    </p>
    <div class="cleartop"></div>

    <p><span class="strong"><g:message code="yesterday"/></span></p>
    <p>
      <g:if test="${eventsYesterday}">
        <g:each in="${eventsYesterday}" var="event" status="i">
          <g:formatDate date="${event.date}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> - <erp:getEvent event="${event}"/><br/>
        </g:each>
      </g:if>
      <g:else>
        <span class="italic"><g:message code="profile.showNews.yesterdayMsg"/></span>
      </g:else>
    </p>--}%
    
  </div>
</div>

</body>