<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>${template.name}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />    
  </head>

  <body>
    <div class="profile-group">Aktivitätsvorlagendetail</div>
    <div class="profile-box">
      <table width="100%">
        <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${template.name}</td></tr>
        <tr><td class="bold titles bezeichnung">Zuordnung:</td><td class="bezeichnung">${template.zuordnung}</td></tr>
        <tr><td class="bold titles bezeichnung">Beschreibung:</td><td class="bezeichnung">${template.beschreibung}</td></tr>
        <tr><td class="bold titles bezeichnung">Dauer:</td><td class="bezeichnung">${template.dauer}</td></tr>
        <tr><td class="bold titles bezeichnung">Sozialform:</td><td class="bezeichnung">${template.sozialform}</td></tr>
        <tr><td class="bold titles bezeichnung">Materialien:</td><td class="bezeichnung">${template.materialien}</td></tr>
        <tr><td class="bold titles bezeichnung">Lernen lernen:</td><td class="bezeichnung">${template.ll}</td></tr>
        <tr><td class="bold titles bezeichnung">Bewegung & Ernährung:</td><td class="bezeichnung">${template.be}</td></tr>
        <tr><td class="bold titles bezeichnung">Persönliche Kompetenz:</td><td class="bezeichnung">${template.pk}</td></tr>
        <tr><td class="bold titles bezeichnung">Soziale & emotionale Intelligenz:</td><td class="bezeichnung">${template.si}</td></tr>
        <tr><td class="bold titles bezeichnung">Handwerk & Kunst:</td><td class="bezeichnung">${template.hk}</td></tr>
        <tr><td class="bold titles bezeichnung">Teilleistungstraining:</td><td class="bezeichnung">${template.tlt}</td></tr>
        <tr><td class="bold titles bezeichnung">Qualifikationen:</td><td class="bezeichnung">${template.qualifikationen}</td></tr>
        <tr><td class="bold titles bezeichnung">Teamgröße:</td><td class="bezeichnung">${template.anzahlPaedagogen}</td></tr>
      </table>
    </div>

  </body>

</html>