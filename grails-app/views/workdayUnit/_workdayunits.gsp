<g:set var="confirmed" value="true"/>

<g:if test="${workdayunits}">
  <g:if test="${!workdayunits[0].confirmed}">
    <g:set var="confirmed" value="false"/>
    <g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'confirmDays']" update="workdayunits" before="if(!confirm('${message(code:'confirm.confirmation')}')) return false">

        <span style="display: none">
          <g:datePicker name="date" value="${date}"/>
        </span>

        <g:submitButton name="button" value="Bestätigen"/>
        <div class="clear"></div>
    </g:formRemote>

    <p>Wenn Sie auf Bestätigen klicken, wird die Zeitaufzeichnung für diesen Tag gespeichert und an den Betreiber abgeschickt. Sie können diesen Vorgang nicht rückgängig machen. Klicken Sie bitte erst auf Bestätigen, wenn der Tag vorbei ist und alle Stunden eingetragen wurden.</p>

  </g:if>
  <g:else>
      <p class="italic red">Dieser Tag wurde bereits bestätigt!</p>
  </g:else>
</g:if>
<g:else>
  <g:set var="confirmed" value="false"/>
</g:else>

<g:if test="${confirmed == 'false'}">
  <g:if test="${workdaycategories}">
    <div style="border: 1px solid #bbb; padding: 5px; margin: 10px 0">
      <p><span class="bold">Einträge erstellen:</span></p>
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
            <td><g:select from="${workdaycategories}" name="category" value=""/></td>
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
  </g:if>
  <g:else>
    <p class="italic red">Es wurden noch keine Arbeitskategorien vom Betreiber angelegt deswegen kann noch keine Zeitaufzeichnung angelegt werden!</p>
  </g:else>
</g:if>

<g:if test="${workdayunits}">
  <g:each in="${workdayunits}" var="unit" status="i">
    <div id="unit-${i}">
      <g:render template="unit" model="[unit: unit, i: i]"/>
    </div>
  </g:each>
</g:if>
<g:else>
  Keine Zeitaufzeichnungen an diesem Tag gefunden!
</g:else>