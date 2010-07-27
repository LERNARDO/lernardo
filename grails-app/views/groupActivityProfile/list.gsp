<head>
  <meta name="layout" content="private"/>
  <title>Aktivitätsblöcke</title>
</head>
<body>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="groupActivityTemplateProfile" action="index">Aktivitätsblockvorlagen</g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1>Aktivitätsblöcke</h1>
  </div>
</div>
<div class="clearFloat"></div>
<div class="boxGray">
  <div class="second">
    <p>${groupTotal} Aktivitätsblöcke insgesamt vorhanden</p>
    <g:if test="${groupTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'groupActivity.profile.name')}"/>
            <th>Datum</th>
          </tr>
          </thead>
          <tbody>
          <g:each in="${groups}" status="i" var="group">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
              <td><g:formatDate date="${group.profile.date}" format="dd. MM. yyyy"/></td>
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>

      <g:if test="${groupTotal > 10}">
        <div class="paginateButtons">
          <g:paginate total="${groupTotal}"/>
        </div>
      </g:if>
    </g:if>

    %{--<div class="buttons">
      <g:link class="buttonBlue" action="create">Neue Aktivitätsvorlagengruppe anlegen</g:link>
      <div class="spacer"></div>
    </div>--}%

  </div>
</div>
</body>
