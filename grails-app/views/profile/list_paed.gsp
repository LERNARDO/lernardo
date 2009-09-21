<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste der Pädagogen</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste der Pädagogen</h2>
      <p>${totalProfiles} Profile gefunden</p>

      <div id="select-box"
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
        <g:sortableColumn property="title" title="Title" />
        <g:sortableColumn property="firstName" title="Vorname" />
        <g:sortableColumn property="lastName" title="Nachname" />
        <g:sortableColumn property="birthDate" title="Geburtsdatum" />
        <g:sortableColumn property="plz" title="PLZ" />
        <g:sortableColumn property="ort" title="Ort" />
        <g:sortableColumn property="strasse" title="Straße" />
        <g:sortableColumn property="mail" title="E-Mail"/>
        <g:sortableColumn property="tel" title="Telefon" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${profileList}" var="profileInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td>${profileInstance.value.title}</td>
            <td><g:link url="/lernardoV2/prf/${profileInstance.value.name}">${profileInstance.value.firstName}</g:link></td>
          <td>${profileInstance.value.lastName}</td>
          <td>${profileInstance.value.birthDate}</td>
          <td>${profileInstance.value.plz}</td>
          <td>${profileInstance.value.ort}</td>
          <td>${profileInstance.value.strasse}</td>
          <td>${profileInstance.value.mail}</td>
          <td>${profileInstance.value.tel}</td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate controller="profile"
                    action="list"
                    params="[profileType:'paed']"
                    total="${totalProfiles}" />
      </div>

    </div>
  </body>
</html>