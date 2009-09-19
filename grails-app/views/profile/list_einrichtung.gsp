<html>
  <head>
      <meta name="layout" content="private" />
      <title>Liste der Einrichtungen</title>
  </head>
<body>
<h2>Liste der Einrichtungen</h2>

<table>
  <thead>
    <tr>
  <g:sortableColumn property="fullName" title="Name" />
  <g:sortableColumn property="plz" title="PLZ" />
  <g:sortableColumn property="ort" title="Ort" />
  <g:sortableColumn property="strasse" title="Straße" />
</tr>
</thead>
<tbody>
<g:each status="i" in="${profileList}" var="profileInstance">
  <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
    <td><g:link url="/lernardoV2/prf/${profileInstance.value.name}">${profileInstance.value.fullName}</g:link></td>
    <td>${profileInstance.value.plz}</td>
    <td>${profileInstance.value.ort}</td>
    <td>${profileInstance.value.strasse}</td>
  </tr>
</g:each>
</tbody>
</table>
</body>
</html>