<div style="border: 1px solid #bbb; padding: 5px; margin: 10px 0">
  <p><span class="bold">Eintrag erstellen:</span></p>
  <g:formRemote name="formRemote2" url="[controller:'workdayUnit', action:'addWorkdayUnit']" update="workdayunits" before="showspinner('#workdayunits')">

    <span style="display: none">
      <g:datePicker name="date" value="${date}"/>
    </span>

    <table>
      <tr>
        <td>Von:</td>
        <td><g:select name="fromHour" from="${0..23}"/>:<g:select name="fromMinute" from="${['00','15','30','45']}"/></td>
      </tr>
      <tr>
        <td>Bis:</td>
        <td><g:select name="toHour" from="${0..23}"/>:<g:select name="toMinute" from="${['00','15','30','45']}"/></td>
      </tr>
      <tr>
        <td>Kategorie:</td>
        <td><g:textField name="category" size="30"/></td>
      </tr>
      <tr>
        <td>Beschreibung:</td>
        <td><g:textArea rows="3" cols="50" name="description"/></td>
      </tr>
    </table>

    <div class="spacer"></div>
    <g:submitButton name="button" value="${message(code:'add')}"/>
    <div class="spacer"></div>
  </g:formRemote>
</div>

<g:if test="${workdayunits}">
  <g:each in="${workdayunits}" var="workday">
    Von: <g:formatDate date="${workday.date1}" format="HH:mm"/><br/>
    Bis: <g:formatDate date="${workday.date2}" format="HH:mm"/><br/>
    Kategorie: ${workday.category}<br/>
    Beschreibung: ${workday.description}<br/><br/>
  </g:each>
</g:if>
<g:else>
  Keine Zeitaufzeichnungen an diesem Tag gefunden!
</g:else>