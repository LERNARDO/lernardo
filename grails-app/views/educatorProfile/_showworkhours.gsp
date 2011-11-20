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
        <td><g:formatNumber number="${educator.profile.workHoursMonday}" format="#0.00"/></td>
        <td><g:formatNumber number="${educator.profile.workHoursTuesday}" format="#0.00"/></td>
        <td><g:formatNumber number="${educator.profile.workHoursWednesday}" format="#0.00"/></td>
        <td><g:formatNumber number="${educator.profile.workHoursThursday}" format="#0.00"/></td>
        <td><g:formatNumber number="${educator.profile.workHoursFriday}" format="#0.00"/></td>
        <td><g:formatNumber number="${educator.profile.workHoursSaturday}" format="#0.00"/></td>
        <td><g:formatNumber number="${educator.profile.workHoursSunday}" format="#0.00"/></td>
        <td><g:formatNumber number="${educator.profile.workHoursMonday + educator.profile.workHoursTuesday + educator.profile.workHoursWednesday + educator.profile.workHoursThursday + educator.profile.workHoursFriday + educator.profile.workHoursSaturday + educator.profile.workHoursSunday}" format="#0.00"/></td>
        <td><g:remoteLink action="changeWorkHours" id="${educator.id}" params="[i: i]" update="${i}a"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:remoteLink></td>
    </tr>
</table>
