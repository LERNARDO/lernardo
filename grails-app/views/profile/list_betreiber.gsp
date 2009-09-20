<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste der Betreiber</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste der Betreiber</h2>
      <p>${profileList.size()} Profile gefunden</p>

      <table>
        <thead>
          <tr>
        <g:sortableColumn params="[profileType: 'betreiber']" property="fullName" title="Name" />
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
            <td><g:link url="/lernardoV2/prf/${profileInstance.value.name}">${fieldValue(bean:profileInstance, field:'value.fullName')}</g:link></td>
          <td>${profileInstance.value.plz}</td>
          <td>${profileInstance.value.ort}</td>
          <td>${profileInstance.value.strasse}</td>
          <td>${profileInstance.value.gemeinnutzigkeit}</td>
          <td>${profileInstance.value.ansprechperson}</td>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
  </body>
</html>