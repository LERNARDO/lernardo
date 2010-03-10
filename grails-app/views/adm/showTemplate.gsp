<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Lernardo | Aktivitätsvorlage</title></head>
  <body>
    <h2>Übersicht > ${template.name}</h2>

    <p><g:link action="overview">zurück zur Übersicht</g:link></p>

    <h3>Details</h3>
    <table class="table">
      <tr>
        <td class="bold">Primäre Zuordnung:</td>
        <td>${template.attribution}</td>
      </tr>
      <tr>
        <td class="bold">Beschreibung:</td>
        <td>${template.description}</td>
      </tr>
      <tr>
        <td class="bold">Dauer:</td>
        <td>${template.duration}</td>
      </tr>
      <tr>
        <td class="bold">Sozialform:</td>
        <td>${template.socialForm}</td>
      </tr>
      <tr>
        <td class="bold">Materialien:</td>
        <td>${template.materials}</td>
      </tr>
      <tr>
        <td class="bold">Lernen lernen:</td>
        <td>${template.ll}</td>
      </tr>
      <tr>
        <td class="bold">Bewegung & Ernährung:</td>
        <td>${template.be}</td>
      </tr>
      <tr>
        <td class="bold">Persönliche Kompetenz:</td>
        <td>${template.pk}</td>
      </tr>
      <tr>
        <td class="bold">Soziale & emotionale Intelligenz:</td>
        <td>${template.si}</td>
      </tr>     
      <tr>
        <td class="bold">Handwerk & Kunst:</td>
        <td>${template.hk}</td>
      </tr>
      <tr>
        <td class="bold">Teilleistungstraining:</td>
        <td>${template.tlt}</td>
      </tr>
      <tr>
        <td class="bold">Benötigte Qualifikationen:</td>
        <td>${template.qualifications}</td>
      </tr>
      <tr>
        <td class="bold">Anzahl Pädagogen:</td>
        <td>${template.requiredEducators}</td>
      </tr>
      <tr>
        <td class="bold">Erstellt am:</td>
        <td>${template.dateCreated}</td>
      </tr>
      <tr>
        <td class="bold">Zuletzt aktualisiert:</td>
        <td>${template.lastUpdated}</td>
      </tr>
    </table>
  
  </body>
</html>