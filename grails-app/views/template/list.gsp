<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste aller Aktivitätsvorlagen</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste aller Aktivitätsvorlagen</h2>
      <p>${templateCount} Aktivitätsvorlagen gefunden</p>

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
        <g:each status="i" in="${templateList}" var="templateInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td class="col"><g:link action="show" id="${templateInstance.value.id}">${fieldValue(bean:templateInstance, field:'value.name')}</g:link></td>
            <td class="col2">${fieldValue(bean:templateInstance, field:'value.dauer')}</td>
            <td>${fieldValue(bean:templateInstance, field:'value.sozialform')}</td>
            <td class="col4">${fieldValue(bean:templateInstance, field:'value.anzahlPaedagogen')}</td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate action="list"
                    total="${templateCount}" />
      </div>

    </div>
  </body>
</html>