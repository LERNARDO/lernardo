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
        <g:sortableColumn property="dauer" title="Dauer" />
        <g:sortableColumn property="sozialform" title="Sozialform" />
        <g:sortableColumn property="anzahlPaedagogen" title="Anzahl Pädagogen" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${actionList}" var="actionInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td>${fieldValue(bean:actionInstance, field:'value.name')}</td>
            <td>${fieldValue(bean:actionInstance, field:'value.dauer')}</td>
            <td>${fieldValue(bean:actionInstance, field:'value.sozialform')}</td>
            <td>${fieldValue(bean:actionInstance, field:'value.anzahlPaedagogen')}</td>
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