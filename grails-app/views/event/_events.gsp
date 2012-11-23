<script type="text/javascript">
  $(document).ready(function() {
    $('.largetooltip').each(function() {
      $(this).qtip({
        content: {
          text: 'Loading...',
          ajax: {
            url: '${grailsApplication.config.grails.serverURL}/profile/getTooltip',
            type: 'GET',
            data: {id : $(this).attr('data-idd')}
          }
        },
          position: {
              my: 'bottom left',
              at: 'top right',
              target: $(this)
          },
        show: {
          delay: 1000
        }
      });
    });
  });
</script>

<%@ page import="at.uenterprise.erp.base.Entity" %>
<g:if test="${events}">
  <table class="default-table">
    <tbody>
    <erp:getBirthdays>
      <g:if test="${entities}">
        <g:each in="${entities}" var="entity">
          <tr>
            <td style="width: 40px;">
              <erp:profileImage entity="${entity}" width="30" height="30" style="vertical-align: middle;"/>
            </td>
            <td class="gray">
              <g:link class="largetooltip" data-idd="${entity.id}" controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}"><span class="bold">${entity.profile.decodeHTML()}</span></g:link> <g:message code="hasBirthday"/> <img src="${resource(dir: 'images/icons', file: 'icon_cake.png')}" alt="Birthday" style="position: relative; top: 3px; margin-right: 5px;"/>
            </td>
          </tr>
        </g:each>
      </g:if>
    </erp:getBirthdays>
    <g:each in="${events}" status="i" var="event">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td style="width: 40px;">
          <erp:profileImage entity="${Entity.get(event.who)}" width="30" height="30" style="vertical-align: middle;"/>
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