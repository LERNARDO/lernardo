<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste der Profile</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste aller Profile</h2>
      <p>${entityCount} Profile gefunden</p>

      <div id="select-box">
        <g:form name="form1" action="list">
          <g:select name="entityType" from="${[all:'Alle',Operator:'Betreiber',Hort:'Horte',Paed:'Pädagogen',Client:'Betreute',User:'User']}" value="${entityType}" optionKey="key" optionValue="value"/>
          <g:submitButton name="list" value="OK" />
        </g:form>
      </div>

      <table id="profile-list">
        <thead>
          <tr>
        <g:sortableColumn property="name" title="Name" />
        <g:sortableColumn property="type" title="Typ" />
        <g:sortableColumn property="role" title="Rechte" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${entityList}" var="entity">
          <tr class="row-${entity.type.name}">
            <td><g:link controller="profile" action="showProfile" params="[name:entity.name]" >${entity.profile.fullName}</g:link></td>
            <td class="col">${entity.type.name}</td>
            <td class="col">${entity.user.authorities.authority}</td>
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
  </body>
</html>