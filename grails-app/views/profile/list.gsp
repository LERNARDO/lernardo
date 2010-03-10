<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Liste aller Profile</title>
  </head>
  <body>
    <div class="headerBlue">
      <h1>Liste aller Profile</h1>
    </div>
  <div class="boxGray">
    <div id="body-list">
      <p>${entityCount} Profile gefunden</p>

      <div id="select-box">
        <g:form name="form1" action="list">
          <g:select name="entityType" from="${[all:'Alle',Betreiber:'Betreiber',Einrichtung:'Einrichtungen',Pädagoge:'Pädagogen',Betreuter:'Betreute',User:'User']}" value="${entityType}" optionKey="key" optionValue="value"/>
          <div class="buttons">
            <g:submitButton name="list" value="OK" />
          </div>
        </g:form>
      </div>

      <table id="profile-list">
        <thead>
          <tr>
          <g:sortableColumn property="name" title="Name" />
          <g:sortableColumn property="type" title="Typ" />
          <th>Aktiv</th>
          <th>Rechte</th>
          <th>Aktionen</th>
          </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${entityList}" var="entity">
          <tr class="row-${entity.type.supertype.name}">
            <td>
              <app:isEnabled entityName="${entity.name}">
                <g:link controller="profile" action="showProfile" id="${entity.id}" >${entity.profile.fullName ?: entity.profile.lastName + " " + entity.profile.firstName}</g:link>
              </app:isEnabled>
              <app:notEnabled entityName="${entity.name}">
                <span class="notEnabled">${entity.profile.fullName}</span>
              </app:notEnabled>
            </td>
            <td class="col">${entity.type.name}</td>
            <td class="col"><app:showBoolean bool="${entity.user.enabled}"/></td>
            <td class="col">${entity.user.authorities.authority}</td>
            <td class="col">
              <app:isEnabled entityName="${entity.name}">
                <g:link controller="profile" action="disable" id="${entity.id}">Deaktivieren</g:link>
              </app:isEnabled>
              <app:notEnabled entityName="${entity.name}">
                <g:link controller="profile" action="enable" id="${entity.id}">Aktivieren</g:link>
              </app:notEnabled>
            </td> 
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate action="list"
                    params="[entityType:entityType]"
                    total="${entityCount}" />
      </div>

    </div>
    </div>
  </body>
</html>