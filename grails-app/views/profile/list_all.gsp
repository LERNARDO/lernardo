<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste aller Profile</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste der aller Profile</h2>

      <table>
        <thead>
          <tr>
        <g:sortableColumn property="title" title="Title" />
        <g:sortableColumn property="fullName" title="Name" />
        <g:sortableColumn property="firstName" title="Vorname" />
        <g:sortableColumn property="lastName" title="Nachname" />
        <g:sortableColumn property="birthDate" title="Geburtsdatum" />
        <g:sortableColumn property="plz" title="PLZ" />
        <g:sortableColumn property="ort" title="Ort" />
        <g:sortableColumn property="strasse" title="Straße" />
        <g:sortableColumn property="mail" title="E-Mail" />
        <g:sortableColumn property="tel" title="Telefon" />
        <g:sortableColumn property="schule" title="Schule" />
        <g:sortableColumn property="klasse" title="Klasse" />
        <g:sortableColumn property="gemeinnutzigkeit" title="Gemeinnützig" />
        <g:sortableColumn property="ansprechperson" title="Ansprechperson" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${profileList}" var="profileInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td>${profileInstance.value.title}</td>
            <td><g:link url="/lernardoV2/prf/${profileInstance.value.name}">${profileInstance.value.fullName}</g:link></td>
          <td><g:link url="/lernardoV2/prf/${profileInstance.value.name}">${profileInstance.value.firstName}</g:link></td>
          <td>${profileInstance.value.lastName}</td>
          <td>${profileInstance.value.birthDate}</td>
          <td>${profileInstance.value.plz}</td>
          <td>${profileInstance.value.ort}</td>
          <td>${profileInstance.value.strasse}</td>
          <td>${profileInstance.value.mail}</td>
          <td>${profileInstance.value.tel}</td>
          <td>${profileInstance.value.schule}</td>
          <td>${profileInstance.value.klasse}</td>
          <td>${profileInstance.value.gemeinnutzigkeit}</td>
          <td>${profileInstance.value.ansprechperson}</td>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
  </body>
</html>