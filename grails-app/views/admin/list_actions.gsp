<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste aller Profile</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste aller Profile</h2>
      <p>${totalActions} Profile gefunden</p>

      <table>
        <thead>
          <tr>
        <g:sortableColumn property="name" title="Rolle" />
        <g:sortableColumn property="beschreibung" title="Title" />
        <g:sortableColumn property="dauer" title="Name" />
        <g:sortableColumn property="sozialform" title="Vorname" />
        <g:sortableColumn property="materialien" title="Nachname" />
        <g:sortableColumn property="gewichtung" title="Geburtsdatum" />
        <g:sortableColumn property="qualifikationen" title="PLZ" />
        <g:sortableColumn property="anzahlPaedagogen" title="Ort" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${actionList}" var="profileInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td>${profileInstance.value.name}</td>
            <td>${profileInstance.value.beschreibung}</td>
            <td>${profileInstance.value.dauer}</td>
            <td>${profileInstance.value.sozialform}</td>
            <td>${profileInstance.value.materialien}</td>
            <td>${profileInstance.value.gewichtung}</td>
            <td>${profileInstance.value.qualifikationen}</td>
            <td>${profileInstance.value.anzahlPaedagogen}</td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate controller="admin"
                    action="list"
                    total="${totalActions}" />
      </div>

    </div>
  </body>
</html>