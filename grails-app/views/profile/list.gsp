<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste der Profile</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste der Profile</h2>
      <p>${profileCount} Profile gefunden</p>

      <div id="select-box">
        <g:form name="form1" action="list">
          <label>Auswahl
            <select name="profileType">
              <option value="all" selected="selected">Alle</option>
              <option value="einrichtung">Einrichtungen</option>
              <option value="betreiber">Betreiber</option>
              <option value="client">Betreute</option>
              <option value="paed">Pädagogen</option>
            </select>                  
          </label>
          <g:submitButton name="list" value="OK" />
        </g:form>
      </div>

      <table id="profile-list">
        <thead>
          <tr>
        <g:sortableColumn property="name" title="Nick" />
        <g:sortableColumn property="type" title="Typ" />
        <g:sortableColumn property="role" title="Rolle" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${profileList}" var="profileInstance">
          <tr class="row-${profileInstance.type.name}">
            <td><g:link controller="profile" action="show" params="[name:profileInstance.name]" >${profileInstance.profile.fullName}</g:link></td>
            <td class="col">${profileInstance.type.name}</td>
            <td class="col">${profileInstance.user.authorities.authority}</td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:set var="pType" value="${profileType}" />
        <g:paginate action="list"
                    params="[profileType:pType]"
                    total="${profileCount}" />
      </div>

    </div>
  </body>
</html>