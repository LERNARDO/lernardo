<table class="default-table">
  <tr>
    <th width="250px">Name</th>
    <th width="500px">Stunden</th>
    <th>Betreuungsbeitrag (monatlich)</th>
  </tr>
</table>

<g:each in="${attendances}" var="attendance" status="i">
  <g:render template="showAttendance" model="[attendance: attendance, i: i]"/>
</g:each>