<table class="default-table">
  <thead>
  <tr>
    <th>Name</th>
    <g:each in="${workdaycategories}" var="category">
      <th>${category.name} (h)</th>
    </g:each>
    <th>Bestätigt</th>
    <th>Habenstunden</th>
    <th>Sollstunden</th>
    <th>Auszahlung</th>
  </tr>
  </thead>
  <tbody>
  <g:each in="${educators}" status="i" var="educator">
    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
      <td><g:link action="show" id="${educator.id}" params="[entity: educator.id]">${fieldValue(bean: educator, field: 'profile.fullName').decodeHTML()}</g:link></td>
      <g:each in="${workdaycategories}" var="category">
        <td><app:getHoursForCategory category="${category}" educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
      </g:each>
      <td>TODO</td>
      <td>%{--<app:getTotalHours educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/>--}%</td>
      <td>TODO</td>
      <td>TODO</td>
    </tr>
  </g:each>
  </tbody>
</table>

<br/>
[PDF erzeugen]