<%@ page import="at.uenterprise.erp.base.Entity" %>

<h4><g:message code="appointment"/> - ${appointment.profile}</h4>

<div class="boxContent" style="clear: both;">

    <table>
      <tbody>

        <tr class="prop">
          <td class="one"><g:message code="owner"/></td>
          <td class="two"><g:link controller="${belongsTo.type.supertype.name + 'Profile'}" action="show" id="${belongsTo.id}" params="[entity: belongsTo.id]">${fieldValue(bean: belongsTo, field: 'profile').decodeHTML()}</g:link></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="title"/></td>
          <td class="two">${fieldValue(bean: appointment, field: 'profile').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/></td>
          <td class="two">${fieldValue(bean: appointment, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="begin"/></td>
          <td class="two"><g:formatDate date="${appointment.profile.beginDate}" format="dd. MM. yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="end"/></td>
          <td class="two"><g:formatDate date="${appointment.profile.endDate}" format="dd. MM. yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.allDay"/></td>
          <td class="two"><g:formatBoolean boolean="${appointment.profile.allDay}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="private"/></td>
          <td class="two"><g:formatBoolean boolean="${appointment.profile.isPrivate}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
        </tr>

      </tbody>
    </table>

    <div class="buttons cleared">
        <erp:accessCheck types="['Betreiber']" me="${belongsTo}">
            <g:formRemote name="formRemote" url="[controller: 'appointmentProfile', action: 'edit', id: appointment.id]" update="content">
                <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
            </g:formRemote>
            <g:formRemote name="formRemote" url="[controller: 'appointmentProfile', action: 'delete', id: appointment.id]" update="content" before="if(!confirm('${message(code:'delete.warn')}')) return false">
                <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}"/></div>
            </g:formRemote>
        </erp:accessCheck>
        <g:remoteLink update="content" class="buttonGray" action="list"><g:message code="back"/></g:remoteLink>
    </div>

</div>
