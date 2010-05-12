<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Aktivitätsvorlagengruppen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Aktivitätsvorlagengruppen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <p>${groupTotal} Aktivitätsvorlagengruppen insgesamt vorhanden</p>
    <g:if test="${groupTotal > 0}">
      <div id="body-list">
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code:'groupActivityTemplate.profile.name')}"/>
            <th>Anzahl Aktivitätsvorlagen</th>
            <th>Gesamtdauer</th>
            %{--<th>Ersteller</th>--}%
          </tr>
          </thead>
          <tbody>
          <g:each in="${groups}" status="i" var="group">
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
              <td><g:link action="show" id="${group.id}">${fieldValue(bean: group, field: 'profile.fullName')}</g:link></td>
              <td><app:getGroupSize entity="${group}"/></td>
              <td><app:getGroupDuration entity="${group}"/></td>
              %{--<td><app:getCreator entity="${group}">${creator.profile.fullName}</app:getCreator></td>--}%
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

    <div class="buttons">
      <g:link class="buttonBlue" action="create">Neue Aktivitätsvorlagengruppe anlegen</g:link>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>
