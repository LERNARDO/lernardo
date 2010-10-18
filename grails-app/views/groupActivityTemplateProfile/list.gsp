<head>
  <meta name="layout" content="private"/>
  <title>Aktivitätsblockvorlagen</title>
</head>
<body>
<div class="tabGreen">
  <div class="second">
    <h1>Aktivitätsblockvorlagen</h1>
  </div>
</div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="groupActivityProfile" action="index">Aktivitätsblöcke</g:link></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <p>${groupTotal} Aktivitätsblockvorlagen insgesamt vorhanden</p>

    <table class="default-table">
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
          <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><app:getGroupSize entity="${group}"/></td>
          <td>${fieldValue(bean: group, field: 'profile.realDuration')}%{--<app:getGroupDuration entity="${group}"/>--}%</td>
          %{--<td><app:getCreator entity="${group}">${creator.profile.fullName}</app:getCreator></td>--}%
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${groupTotal}"/>
    </div>

    <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false">
      <div class="buttons">
        <g:link class="buttonGreen" action="create">Neue Aktivitätsblockvorlage anlegen</g:link>
        <div class="spacer"></div>
      </div>
    </app:accessCheck>

  </div>
</div>
</body>
