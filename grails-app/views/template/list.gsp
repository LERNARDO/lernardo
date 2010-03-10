  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Lernardo Aktivitätsvorlagen</title>
  </head>

  <body>
    <g:if test="${entity.profile.showTips}">
      <div class="toolTip">
        <b><img src="${createLinkTo(dir:'images/icons',file:'icon_template.png')}" alt="toolTip" align="top"/>Tipp:</b> Diese Seite bietet einen Überblick über sämtliche im Lernardo erfassten Aktivitätsvorlagen.
      </div>
    </g:if>
    <div class="headerBlue">
    <h1>Lernardo Aktivitätsvorlagen</h1>
    </div>
    <div class="boxGray">
    <div id="body-list">
      <div style="float:right;">
        <app:isEducator entity="${entity}">
          <li class="profile-template"><g:link class="buttonBlue" controller="template" action="create">Aktivitätsvorlage erstellen</g:link></li>
        </app:isEducator>
      </div>
      <p>${templateCount} Aktivitätsvorlage(n) gefunden</p>

      <table>
        <thead>
          <tr>
        <g:sortableColumn property="name" title="Name" />
        <g:sortableColumn property="duration" title="Dauer (min)" />
        <g:sortableColumn property="socialForm" title="Sozialform" />
        %{--<g:sortableColumn property="requiredEducators" title="P&auml;dagogen" />--}%
        <th>Kommentare</th>
        </tr>
        </thead>

        <tbody>
        <g:each status="i" in="${templateList}" var="templateInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td class="col"><g:link action="show" id="${templateInstance.id}" params="[name:entity.name]">${templateInstance.profile.fullName}</g:link></td>
            <td class="col2">${templateInstance.profile.duration}</td>
            <td>${templateInstance.profile.socialForm}</td>
            %{--<td class="col4">${templateInstance.requiredEducators}</td>--}%
            <td><app:getTemplateCommentsCount template="${templateInstance}"/></td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <g:if test="${templateCount > 15}">
        <div class="paginateButtons">
          <g:paginate action="list" total="${templateCount}" />
        </div>
      </g:if>

    </div>
      </div>
  </body>