<%--
Created by IntelliJ IDEA.
    User: mkuhl
Date: 27.09.2009
Time: 16:08:55
To change this template use File | Settings | File Templates.
    --%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>${title}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />    
  </head>

  <body>
    <div class="profile-group label">Neue Aktivität planen</div>
    <div class="profile-box">
      <g:form action="save" >
        <table>
          <tr>
            <td class="bold titles bezeichnung">Vorlagenname:</td>
            <td class="bezeichnung">${name}</td>
          </tr>
          <tr>
            <td class="bold titles bezeichnung">Datum:</td>
            <td class="bezeichnung"><input type="text" id="data" name="date" value="${date}"/></td>
          </tr>
          <tr>
            <td class="bold titles bezeichnung">Beginn:</td>
            <td class="bezeichnung"><input type="text" id="startTime" name="startTime" value="${startTime}"/></td>
          </tr>
          <tr>
            <td class="bold titles bezeichnung">Länge:</td>
            <td class="bezeichnung"><input type="text" id="duration" name="duration" value="${duration}"/></td>
          </tr>
          <tr>
            <td class="bold titles bezeichnung">Einrichtung:</td>
            <td class="bezeichnung" name="strasse"><input type="text" id="einrichtung" name="einrichtung" value=""/></td>
          </tr>
          <tr>
            <td class="bold titles bezeichnung">Team:</td>
            <td class="bezeichnung" name="gemeinnutzigkeit"><input type="text" id="fullName" name="gemeinnutzigkeit" value=""/></td>
          </tr>
          <tr>
            <td class="bold titles bezeichnung">Teilnehmer:</td>
            <td class="bezeichnung" name ="ansprechperson"><input type="text" id="fullName" name="ansprechperson" value=""/></td>
          </tr>
        </table>
        <input name="name "type="hidden" value="${name}" />
        <span class="button"><g:actionSubmit name="save" action="save" value="Speichern" /></span>
        <span class="button"><g:actionSubmit name="cancel" action="cancel" value="Abbrechen" /></span>
      </g:form>
    </div>

  </body>


</html>