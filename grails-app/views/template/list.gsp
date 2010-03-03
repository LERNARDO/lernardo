  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Lernardo Aktivitätsvorlagen</title>
  </head>

  <body>
    <g:if test="${entity.profile.showTips}">
      <div class="toolTip">
        <b><img src="${createLinkTo(dir:'images/icons',file:'icon_template.png')}" alt="toolTip"/>Tipp:</b> Diese Seite bietet einen Überblick über sämtliche im Lernardo erfassten Aktivitätsvorlagen.
      </div>
    </g:if>
    <div class="headerBlue">
    <h1>Lernardo Aktivitätsvorlagen</h1>
    </div>
    <div class="boxGray">
    <div id="body-list">
      <div style="float:right;">
        <app:isPaed entity="${entity}">
          <li class="profile-template"><g:link class="buttonBlue" controller="template" action="create">Aktivitätsvorlage erstellen</g:link></li>
        </app:isPaed>
      </div>
      <p>${templateCount} Aktivitätsvorlagen gefunden</p>

      <table>
        <thead>
          <tr>
        <g:sortableColumn property="name" title="Name" />
        <g:sortableColumn property="duration" title="Dauer (min)" />
        <g:sortableColumn property="socialForm" title="Sozialform" />
        %{--<g:sortableColumn property="requiredPaeds" title="P&auml;dagogen" />--}%
        <th>Kommentare</th>
        </tr>
        </thead>

        <tbody>
        <g:each status="i" in="${templateList}" var="templateInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td class="col"><g:link action="show" id="${templateInstance.id}" params="[name:entity.name]">${templateInstance.name}</g:link></td>
            <td class="col2">${templateInstance.duration}</td>
            <td>${templateInstance.socialForm}</td>
            %{--<td class="col4">${templateInstance.requiredPaeds}</td>--}%
            <td><app:getTemplateCommentsCount template="${templateInstance}"/></td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate action="list" total="${templateCount}" />
      </div>

    </div>
      </div>
  </body>