<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste aller Aktivitätsvorlagen</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste aller Aktivitätsvorlagen</h2>
      <p>${totalActions} Aktivitätsvorlagen gefunden</p>

      <table>
        <thead>
          <tr>
        <g:sortableColumn property="name" title="Name" />
        <g:sortableColumn property="beschreibung" title="Beschreibung" />
        <g:sortableColumn property="dauer" title="Dauer" />
        <g:sortableColumn property="sozialform" title="Sozialform" />
        <g:sortableColumn property="materialien" title="Materialien" />
        <g:sortableColumn property="ll" title="Lernen lernen" />
        <g:sortableColumn property="be" title="Bewegung & Ernährung" />
        <g:sortableColumn property="pk" title="Persönliche Kompetenz" />
        <g:sortableColumn property="si" title="Soziale und emotionale Intelligenz" />
        <g:sortableColumn property="hk" title="Handwerk & Kunst" />
        <g:sortableColumn property="tlt" title="Teilleistungstraining" />
        <g:sortableColumn property="qualifikationen" title="Qualifikationen" />
        <g:sortableColumn property="anzahlPaedagogen" title="Anzahl Pädagogen" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${actionList}" var="actionInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td>${actionInstance.value.name}</td>
            <td>${actionInstance.value.beschreibung}</td>
            <td>${actionInstance.value.dauer}</td>
            <td>${actionInstance.value.sozialform}</td>
            <td>${actionInstance.value.materialien}</td>
            <td>${actionInstance.value.ll}</td>
            <td>${actionInstance.value.be}</td>
            <td>${actionInstance.value.pk}</td>
            <td>${actionInstance.value.si}</td>
            <td>${actionInstance.value.hk}</td>
            <td>${actionInstance.value.tlt}</td>
            <td>${actionInstance.value.qualifikationen}</td>
            <td>${actionInstance.value.anzahlPaedagogen}</td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate controller="admin"
                    action="listActions"
                    total="${totalActions}" />
      </div>

    </div>
  </body>
</html>