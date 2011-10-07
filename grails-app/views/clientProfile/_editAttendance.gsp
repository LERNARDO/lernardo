<script type="text/javascript">
  $(document).ready(function() {
    $('.timepicker').timepicker();
  });
</script>

<g:formRemote name="updateAttendance" update="attendances" url="[action:'updateAttendance', id: client.id]">
<table class="simpleTable">
    <tr>
        <th><g:actionSubmitImage value="confirm" src="${resource(dir: 'images/icons', file: 'icon_tick.png')}" alt="${message(code: 'confirm')}" align="top" style="border: 0"/></th>
        <th><g:message code="monday.short"/></th>
        <th><g:message code="tuesday.short"/></th>
        <th><g:message code="wednesday.short"/></th>
        <th><g:message code="thursday.short"/></th>
        <th><g:message code="friday.short"/></th>
        <th><g:message code="saturday.short"/></th>
        <th><g:message code="sunday.short"/></th>
    </tr>
    <tr>
        <td><g:message code="from"/></td>
        <td><g:textField name="mondayFrom" class="timepicker" size="4" value="${formatDate(date: client?.profile?.mondayFrom, format: 'HH:mm')}"/></td>
        <td><g:textField name="tuesdayFrom" class="timepicker" size="4" value="${formatDate(date: client?.profile?.tuesdayFrom, format: 'HH:mm')}"/></td>
        <td><g:textField name="wednesdayFrom" class="timepicker" size="4" value="${formatDate(date: client?.profile?.wednesdayFrom, format: 'HH:mm')}"/></td>
        <td><g:textField name="thursdayFrom" class="timepicker" size="4" value="${formatDate(date: client?.profile?.thursdayFrom, format: 'HH:mm')}"/></td>
        <td><g:textField name="fridayFrom" class="timepicker" size="4" value="${formatDate(date: client?.profile?.fridayFrom, format: 'HH:mm')}"/></td>
        <td><g:textField name="saturdayFrom" class="timepicker" size="4" value="${formatDate(date: client?.profile?.saturdayFrom, format: 'HH:mm')}"/></td>
        <td><g:textField name="sundayFrom" class="timepicker" size="4" value="${formatDate(date: client?.profile?.sundayFrom, format: 'HH:mm')}"/></td>
    </tr>
    <tr>
        <td><g:message code="to"/></td>
        <td><g:textField name="mondayTo" class="timepicker" size="4" value="${formatDate(date: client?.profile?.mondayTo, format: 'HH:mm')}"/></td>
        <td><g:textField name="tuesdayTo" class="timepicker" size="4" value="${formatDate(date: client?.profile?.tuesdayTo, format: 'HH:mm')}"/></td>
        <td><g:textField name="wednesdayTo" class="timepicker" size="4" value="${formatDate(date: client?.profile?.wednesdayTo, format: 'HH:mm')}"/></td>
        <td><g:textField name="thursdayTo" class="timepicker" size="4" value="${formatDate(date: client?.profile?.thursdayTo, format: 'HH:mm')}"/></td>
        <td><g:textField name="fridayTo" class="timepicker" size="4" value="${formatDate(date: client?.profile?.fridayTo, format: 'HH:mm')}"/></td>
        <td><g:textField name="saturdayTo" class="timepicker" size="4" value="${formatDate(date: client?.profile?.saturdayTo, format: 'HH:mm')}"/></td>
        <td><g:textField name="sundayTo" class="timepicker" size="4" value="${formatDate(date: client?.profile?.sundayTo, format: 'HH:mm')}"/></td>
    </tr>
</table>

</g:formRemote>
