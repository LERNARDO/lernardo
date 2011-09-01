<g:formRemote name="editWorkHours" update="${i}a" url="[action:'updateWorkHours', id: educator.id, params:[i: i]]">
  <table>
    <tr>
        <td><span class="bold"><g:message code="monday.short"/></span></td>
        <td><span class="bold"><g:message code="tuesday.short"/></span></td>
        <td><span class="bold"><g:message code="wednesday.short"/></span></td>
        <td><span class="bold"><g:message code="thursday.short"/></span></td>
        <td><span class="bold"><g:message code="friday.short"/></span></td>
        <td><span class="bold"><g:message code="saturday.short"/></span></td>
        <td><span class="bold"><g:message code="sunday.short"/></span></td>
        <td></td>
    </tr>
    <tr>
        <td><g:textField size="2" name="workHoursMonday" value="${fieldValue(bean: educator, field: 'profile.workHoursMonday')}"/></td>
        <td><g:textField size="2" name="workHoursTuesday" value="${fieldValue(bean: educator, field: 'profile.workHoursTuesday')}"/></td>
        <td><g:textField size="2" name="workHoursWednesday" value="${fieldValue(bean: educator, field: 'profile.workHoursWednesday')}"/></td>
        <td><g:textField size="2" name="workHoursThursday" value="${fieldValue(bean: educator, field: 'profile.workHoursThursday')}"/></td>
        <td><g:textField size="2" name="workHoursFriday" value="${fieldValue(bean: educator, field: 'profile.workHoursFriday')}"/></td>
        <td><g:textField size="2" name="workHoursSaturday" value="${fieldValue(bean: educator, field: 'profile.workHoursSaturday')}"/></td>
        <td><g:textField size="2" name="workHoursSunday" value="${fieldValue(bean: educator, field: 'profile.workHoursSunday')}"/></td>
        <td><g:actionSubmitImage value="confirm" src="${resource(dir: 'images/icons', file: 'icon_tick.png')}" alt="${message(code: 'confirm')}" align="top" style="border: 0"/></td>
    </tr>
</table>

</g:formRemote>