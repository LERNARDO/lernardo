<g:set var="confirmed" value="true"/>

<g:if test="${workdayunits}">
  <g:if test="${!workdayunits[0].confirmed}">
    <g:set var="confirmed" value="false"/>
    <g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'confirmDays']" update="workdayunits" before="if(!confirm('${message(code:'confirm.confirmation')}')) return false">

        <span style="display: none">
          <g:datePicker name="date" value="${date}"/>
        </span>

        <g:submitButton name="button" value="Tag bestätigen"/>
        <div class="clear"></div>
    </g:formRemote>

    <p><g:message code="workdayUnit.confirmation"/></p>

  </g:if>
  <g:else>
      <p class="italic red"><g:message code="workdayUnit.dayConfirmed"/></p>
  </g:else>
</g:if>
<g:else>
  <g:set var="confirmed" value="false"/>
</g:else>

<g:if test="${confirmed == 'false'}">
  <g:if test="${workdaycategories}">
    <div style="border: 1px solid #bbb; border-radius: 5px; padding: 5px; margin: 10px 0">
      <p><span class="bold"><g:message code="workdayUnit.createEntry"/></span></p>
      <g:formRemote name="formRemote2" url="[controller:'workdayUnit', action:'addWorkdayUnit']" update="workdayunits" before="showspinner('#workdayunits')">

        <span style="display: none">
          <g:datePicker name="date" value="${date}"/>
        </span>

        <table>
          <tr>
            <td><g:message code="from"/>:</td>
            <td><g:select name="fromHour" from="${0..23}"/>:<g:select name="fromMinute" from="${['00','15','30','45']}"/></td>
          </tr>
          <tr>
            <td><g:message code="to"/>:</td>
            <td><g:select name="toHour" from="${0..23}"/>:<g:select name="toMinute" from="${['00','15','30','45']}"/></td>
          </tr>
          <tr>
            <td><g:message code="workdayCategory"/>:</td>
            <td><g:select from="${workdaycategories}" name="category" value=""/></td>
          </tr>
          <tr>
            <td><g:message code="description"/>:</td>
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
    <p class="italic red"><g:message code="workdayUnit.noCategoriesYet"/></p>
  </g:else>
</g:if>

<p class="bold">Bereits eingetragene Zeitaufzeichnungen</p>
<g:if test="${workdayunits}">
  <g:each in="${workdayunits}" var="unit" status="i">
    %{--TODO: find out why this styling won't work when used in common.less--}%
    <div id="unit-${i}" style="background-color: #dfdfdf; border: 1px solid #ccc; padding: 5px 6px; border-radius: 5px; margin: 5px 0 0 0;">
      <g:render template="unit" model="[unit: unit, i: i]"/>
    </div>
  </g:each>
</g:if>
<g:else>
  <span class="italic red"><g:message code="workdayUnit.noEntries"/></span>
</g:else>