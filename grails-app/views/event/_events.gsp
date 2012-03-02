<%@ page import="at.openfactory.ep.Entity" %>
<g:if test="${events}">
  <table class="default-table">
    <tbody>
    <erp:getBirthdays>
      <g:if test="${entities}">
        <g:each in="${entities}" var="entity">
          <tr>
            <td style="width: 40px;">
              <erp:profileImage entity="${entity}" width="30" style="vertical-align: middle;"/>
            </td>
            <td class="gray">
              <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}"><span class="bold">${entity.profile.fullName.decodeHTML()}</span></g:link> hat heute Geburtstag! <img src="${resource(dir: 'images/icons', file: 'icon_cake.png')}" alt="Birthday" style="position: relative; top: 3px; margin-right: 5px;"/>
            </td>
          </tr>
        </g:each>
      </g:if>
    </erp:getBirthdays>
    <g:each in="${events}" status="i" var="event">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td style="width: 40px;">
          <erp:profileImage entity="${Entity.get(event.who)}" width="30" style="vertical-align: middle;"/>
        </td>
        <td class="gray">
          <g:formatDate date="${event.date}" format="EE dd. MMM. yyyy - HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/>
          <erp:getEvent event="${event}"/> <erp:isSystemAdmin><g:link action="delete" id="${event.id}" onclick="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="Birthday" style="position: relative; top: 3px; margin-right: 5px;"/></g:link></erp:isSystemAdmin>
        </td>
      </tr>
    </g:each>
    </tbody>
  </table>

  <div class="paginateButtons">
    <util:remotePaginate action="remoteEvents" total="${totalEvents}" update="events" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}"/>
  </div>
</g:if>