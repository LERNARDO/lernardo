<html>
  <head>
      <meta name="layout" content="private" />
      <title>Liste der Betreuten</title>
  </head>
<body>

<h2>Liste der Betreuten</h2>

<table>
  <thead>
    <tr>
  <g:sortableColumn params="[profileType: 'client']" property="firstName" title="Vorname" />
  <g:sortableColumn property="lastName" title="Nachname" />
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
<g:each status="i" in="${profileList}" var="profileInstance">
  <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
    <td><g:link action="show" id="${profileInstance.value.name}">${fieldValue(bean:profileInstance, field:'value.firstName')}</g:link></td>
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
</body>
</html>