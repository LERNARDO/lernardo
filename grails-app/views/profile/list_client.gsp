
<h2>List of -${profileType}- Profiles</h2>

<!--<p>${profileList} Einträge gefunden</p>-->

<table>
  <thead>
    <tr>
  <g:sortableColumn property="firstName" title="Vorname" />
  <g:sortableColumn property="LastName" title="Nachname" />
  <g:sortableColumn property="birthDate" title="Geburtsdatum" />
  <g:sortableColumn property="plz" title="PLZ" />
  <g:sortableColumn property="ort" title="Ort" />
  <g:sortableColumn property="strasse" title="Straße" />
  <g:sortableColumn property="mail" title="E-Mail"/>
  <g:sortableColumn property="tel" title="Telefon" />
  <g:sortableColumn property="schule" title="Schule" />
  <g:sortableColumn property="klasse" title="Klasse" /></tr>
</thead>
<tbody>
<g:each in="${profileList}" var="profileInstance">
  <tr >
    <td>${profileInstance.value.firstName}</td>
    <td>${profileInstance.value.lastName}</td>
    <td>${profileInstance.value.birthDate}</td>
    <td>${profileInstance.value.plz}</td>
    <td>${profileInstance.value.ort}</td>
    <td>${profileInstance.value.strasse}</td>
    <td>${profileInstance.value.mail}</td>
    <td>${profileInstance.value.tel}</td>
    <td>${profileInstance.value.schule}</td>
    <td>${profileInstance.value.klasse}</td>
  </tr>
</g:each>
</tbody>
</table>