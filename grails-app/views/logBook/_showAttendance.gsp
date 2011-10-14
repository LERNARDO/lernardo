<div id="attendance${i}">
  <table class="default-table">
    <tr>
      <td valign="top" width="250px">${attendance.client.profile.fullName}</td>
      <td width="500px">
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
              <td>Anwesend?</td>
              <td><g:formatBoolean boolean="${attendance.monday}" true="Ja" false="-"/></td>
              <td><g:formatBoolean boolean="${attendance.tuesday}" true="Ja" false="-"/></td>
              <td><g:formatBoolean boolean="${attendance.wednesday}" true="Ja" false="-"/></td>
              <td><g:formatBoolean boolean="${attendance.thursday}" true="Ja" false="-"/></td>
              <td><g:formatBoolean boolean="${attendance.friday}" true="Ja" false="-"/></td>
              <td><g:formatBoolean boolean="${attendance.saturday}" true="Ja" false="-"/></td>
              <td><g:formatBoolean boolean="${attendance.sunday}" true="Ja" false="-"/></td>
          </tr>
          <tr>
              <td><g:message code="from"/></td>
              <td>${attendance.mondayFrom ? formatDate(date: attendance.mondayFrom, format: 'HH:mm') : '-'}</td>
              <td>${attendance.tuesdayFrom ? formatDate(date: attendance.tuesdayFrom, format: 'HH:mm') : '-'}</td>
              <td>${attendance.wednesdayFrom ? formatDate(date: attendance.wednesdayFrom, format: 'HH:mm') : '-'}</td>
              <td>${attendance.thursdayFrom ? formatDate(date: attendance.thursdayFrom, format: 'HH:mm') : '-'}</td>
              <td>${attendance.fridayFrom ? formatDate(date: attendance.fridayFrom, format: 'HH:mm') : '-'}</td>
              <td>${attendance.saturdayFrom ? formatDate(date: attendance.saturdayFrom, format: 'HH:mm') : '-'}</td>
              <td>${attendance.sundayFrom ? formatDate(date: attendance.sundayFrom, format: 'HH:mm') : '-'}</td>
          </tr>
          <tr>
              <td><g:message code="to"/></td>
              <td>${attendance.mondayTo ? formatDate(date: attendancemondayTo, format: 'HH:mm') : '-'}</td>
              <td>${attendance.tuesdayTo ? formatDate(date: attendance.tuesdayTo, format: 'HH:mm') : '-'}</td>
              <td>${attendance.wednesdayTo ? formatDate(date: attendance.wednesdayTo, format: 'HH:mm') : '-'}</td>
              <td>${attendance.thursdayTo ? formatDate(date: attendance.thursdayTo, format: 'HH:mm') : '-'}</td>
              <td>${attendance.fridayTo ? formatDate(date: attendance.fridayTo, format: 'HH:mm') : '-'}</td>
              <td>${attendance.saturdayTo ? formatDate(date:attendance.saturdayTo, format: 'HH:mm') : '-'}</td>
              <td>${attendance.sundayTo ? formatDate(date: attendance.sundayTo, format: 'HH:mm') : '-'}</td>
          </tr>
        </table>
      </td>
      <td valign="top">${attendance.costs} €
        <div style="padding: 75px 0 0 145px">
          <g:remoteLink update="attendance${i}" action="editAttendance" id="${attendance.id}" params="[i: i]">Ändern</g:remoteLink>
        </div>
      </td>
    </tr>
  </table>
</div>