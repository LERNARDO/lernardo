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
                    target: 'mouse' //$(this)
                },
                show: {
                    delay: 1000
                }
            });
        });
    });
</script>

<g:if test="${persons}">
  <table class="default-table">
    <thead>
    <tr>
      <th><g:message code="name"/></th>
      <th><g:message code="hours"/></th>
      %{--<th>Arbeitstage pro Woche</th>--}%
      <th><g:message code="educator.profile.hourlyWage"/> (${grailsApplication.config.currency})</th>
      <th><g:message code="educator.profile.overtimePay"/> (${grailsApplication.config.currency})</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${persons}" status="i" var="person">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td>
          <erp:profileImage entity="${person}" width="30" height="30" style="vertical-align: middle; margin: 0 10px 0 0;"/>
          <g:link class="largetooltip" data-idd="${person.id}" controller="${person.type.supertype.name + 'Profile'}" action="show" id="${person.id}" params="[entity: person.id]">${fieldValue(bean: person, field: 'profile').decodeHTML()}</g:link>
        </td>
        <td id="${i}a"><g:render template="showworkhours" model="[person: person, i: i]"/></td>
        %{--<td id="${i}b"><g:render template="showworkdays" model="[educator: educator, i: i]"/></td>--}%
        <td id="${i}c"><g:render template="showhourlywage" model="[person: person, i: i]"/></td>
        <td id="${i}d"><g:render template="showovertimepay" model="[person: person, i: i]"/></td>
      </tr>
    </g:each>
    </tbody>
  </table>

  <div class="paginateButtons">
    <util:remotePaginate controller="workdayUnit" action="showPersons" total="${totalResults}" update="result" before="showspinner('#result')" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}" params="${params}"/>
  </div>
</g:if>
<g:else>
  <span class="gray italic"><g:message code="searchMe.empty"/></span>
</g:else>