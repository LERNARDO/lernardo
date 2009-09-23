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

      <table>
        <thead>
          <tr>
            <g:sortableColumn property="role" title="Rolle" />
            <g:sortableColumn property="fullName" title="Name" />
          </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${profileList}" var="profileInstance">
          <tr class="row-${profileInstance.value.type}">
            <td>${profileInstance.value.role}</td>
            <td><g:link url="/lernardoV2/prf/${profileInstance.value.name}">${profileInstance.value.fullName}</g:link></td>
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