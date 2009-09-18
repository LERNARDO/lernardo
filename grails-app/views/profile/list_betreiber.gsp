<h2>List of -${profileType}- Profiles</h2>

<!--<p>${profileList} Einträge gefunden</p>-->

<table>
  <thead>
    <tr>
  <g:sortableColumn property="fullName" title="Name" />
  <g:sortableColumn property="plz" title="PLZ" />
  <g:sortableColumn property="ort" title="Ort" />
  <g:sortableColumn property="strasse" title="Straße" />
  <g:sortableColumn property="gemeinnutzigkeit" title="Gemeinnützig"/>
  <g:sortableColumn property="ansprechperson" title="Ansprechperson" />
</tr>
</thead>
<tbody>
<g:each status="i" in="${profileList}" var="profileInstance">
  <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
    <td>${profileInstance.value.fullName}</td>
    <td>${profileInstance.value.plz}</td>
    <td>${profileInstance.value.ort}</td>
    <td>${profileInstance.value.strasse}</td>
    <td>${profileInstance.value.gemeinnutzigkeit}</td>
    <td>${profileInstance.value.ansprechperson}</td>
  </tr>
</g:each>
</tbody>
</table>