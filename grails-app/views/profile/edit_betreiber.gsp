<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <title>Profil - Betreiber</title>
  </head>
  <body>
    <h2>Profil für Betreiber: -${name}-</h2>
  <g:form method="post" >
    <table>
      <tr>
        <td class="bold titles">Name:</td>
        <td><input type="text" id="fullName" name="fullName" value="${fieldValue(bean:prf,field:'fullName')}"/></td>
      </tr>
      <tr>
        <td class="bold titles">PLZ:</td>
        <td>${plz}</td>
      </tr>
      <tr>
        <td class="bold titles">Ort:</td>
        <td>${ort}</td>
      </tr>
      <tr>
        <td class="bold titles">Straße:</td>
        <td>${strasse}</td>
      </tr>
      <tr>
        <td class="bold titles">Gemeinnützigkeit:</td>
        <td>${gemeinnutzigkeit}</td>
      </tr>
      <tr>
        <td class="bold titles">Ansprechperson:</td>
        <td>${ansprechperson}</td>
      </tr>
    </table>
    <ul>
      <li><a href="/lernardoV2/prf/alpha">Verein Alpha - Frauen für die Zukunft</a></li>
      <li><a href="/lernardoV2/prf/lernardo">LERNARDO Lernen - Wachsen</a></li>
    </ul>
    <input type="hidden" name="type" value="${type}" />
    <input type="hidden" name="id" value="${name}" />
    <span class="button"><g:actionSubmit class="save" value="Save" /></span>
  </g:form>
</body>
</html>