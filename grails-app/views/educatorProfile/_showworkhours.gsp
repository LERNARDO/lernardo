<table>
    <tr>
        <td><span class="bold">MO</span></td>
        <td><span class="bold">DI</span></td>
        <td><span class="bold">MI</span></td>
        <td><span class="bold">DO</span></td>
        <td><span class="bold">FR</span></td>
        <td><span class="bold">SA</span></td>
        <td><span class="bold">SO</span></td>
        <td><span class="bold">&sum;</span></td>
        <td></td>
    </tr>
    <tr>
        <td>${fieldValue(bean: educator, field: 'profile.workHoursMonday')}</td>
        <td>${fieldValue(bean: educator, field: 'profile.workHoursTuesday')}</td>
        <td>${fieldValue(bean: educator, field: 'profile.workHoursWednesday')}</td>
        <td>${fieldValue(bean: educator, field: 'profile.workHoursThursday')}</td>
        <td>${fieldValue(bean: educator, field: 'profile.workHoursFriday')}</td>
        <td>${fieldValue(bean: educator, field: 'profile.workHoursSaturday')}</td>
        <td>${fieldValue(bean: educator, field: 'profile.workHoursSunday')}</td>
        <td>${educator.profile.workHoursMonday + educator.profile.workHoursTuesday + educator.profile.workHoursWednesday + educator.profile.workHoursThursday + educator.profile.workHoursFriday + educator.profile.workHoursSaturday + educator.profile.workHoursSunday}</td>
        <td><g:remoteLink action="changeWorkHours" id="${educator.id}" params="[i: i]" update="${i}a"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:remoteLink></td>
    </tr>
</table>
