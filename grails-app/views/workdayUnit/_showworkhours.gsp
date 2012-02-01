<table>
    <tr>
        <td><span class="gray"><g:message code="monday.short"/></span></td>
        <td><span class="gray"><g:message code="tuesday.short"/></span></td>
        <td><span class="gray"><g:message code="wednesday.short"/></span></td>
        <td><span class="gray"><g:message code="thursday.short"/></span></td>
        <td><span class="gray"><g:message code="friday.short"/></span></td>
        <td><span class="gray"><g:message code="saturday.short"/></span></td>
        <td><span class="gray"><g:message code="sunday.short"/></span></td>
        <td><span class="gray">&sum;</span></td>
        <td></td>
    </tr>
    <tr>
        <td><g:formatNumber number="${person.profile.workHoursMonday}" format="#0.00"/></td>
        <td><g:formatNumber number="${person.profile.workHoursTuesday}" format="#0.00"/></td>
        <td><g:formatNumber number="${person.profile.workHoursWednesday}" format="#0.00"/></td>
        <td><g:formatNumber number="${person.profile.workHoursThursday}" format="#0.00"/></td>
        <td><g:formatNumber number="${person.profile.workHoursFriday}" format="#0.00"/></td>
        <td><g:formatNumber number="${person.profile.workHoursSaturday}" format="#0.00"/></td>
        <td><g:formatNumber number="${person.profile.workHoursSunday}" format="#0.00"/></td>
        <td><g:formatNumber number="${person.profile.workHoursMonday + person.profile.workHoursTuesday + person.profile.workHoursWednesday + person.profile.workHoursThursday + person.profile.workHoursFriday + person.profile.workHoursSaturday + person.profile.workHoursSunday}" format="#0.00"/></td>
        <td><g:remoteLink action="changeWorkHours" id="${person.id}" params="[i: i]" update="${i}a"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:remoteLink></td>
    </tr>
</table>
