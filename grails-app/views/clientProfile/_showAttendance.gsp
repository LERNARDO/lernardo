<table class="simpleTable">
    <tr>
        <th>&nbsp;</th>
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
        <td>${client.profile.mondayFrom ? formatDate(date: client?.profile?.mondayFrom, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.tuesdayFrom ? formatDate(date: client?.profile?.tuesdayFrom, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.wednesdayFrom ? formatDate(date: client?.profile?.wednesdayFrom, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.thursdayFrom ? formatDate(date: client?.profile?.thursdayFrom, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.fridayFrom ? formatDate(date: client?.profile?.fridayFrom, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.saturdayFrom ? formatDate(date: client?.profile?.saturdayFrom, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.sundayFrom ? formatDate(date: client?.profile?.sundayFrom, format: 'HH:mm') : '-'}</td>
    </tr>
    <tr>
        <td><g:message code="to"/></td>
        <td>${client.profile.mondayTo ? formatDate(date: client?.profile?.mondayTo, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.tuesdayTo ? formatDate(date: client?.profile?.tuesdayTo, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.wednesdayTo ? formatDate(date: client?.profile?.wednesdayTo, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.thursdayTo ? formatDate(date: client?.profile?.thursdayTo, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.fridayTo ? formatDate(date: client?.profile?.fridayTo, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.saturdayTo ? formatDate(date: client?.profile?.saturdayTo, format: 'HH:mm') : '-'}</td>
        <td>${client.profile.sundayTo ? formatDate(date: client?.profile?.sundayTo, format: 'HH:mm') : '-'}</td>
    </tr>
</table>