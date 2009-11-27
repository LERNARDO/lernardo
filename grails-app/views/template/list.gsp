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
        <g:sortableColumn property="duration" title="Dauer (min)" />
        <g:sortableColumn property="socialForm" title="Sozialform" />
        <g:sortableColumn property="requiredPaeds" title="P&auml;dagogen" />
        <th>Kommentare</th>
        </tr>
        </thead>

        <tbody>
        <g:each status="i" in="${templateList}" var="templateInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td class="col"><g:link action="show" id="${templateInstance.id}" params="[name:entity.name]">${templateInstance.name}</g:link></td>
            <td class="col2">${templateInstance.duration}</td>
            <td>${templateInstance.socialForm}</td>
            <td class="col4">${templateInstance.requiredPaeds}</td>
            <td><app:getTemplateCommentsCount template="${templateInstance}"/></td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate action="list" total="${templateCount}" />
      </div>

    </div>
  </body>