<%@ page import="at.uenterprise.erp.WorkdayCategory" %>
<g:formRemote name="formRemote" url="[controller:'workdayUnit', action:'updateUnit', id: workdayUnit.id, params: [i: i, entity: entity.id]]" update="unit-${i}" before="showspinner('#unit-${i}')">

    <table>
      <tr>
        <td><g:message code="from"/>:</td>
        <td><g:select name="fromHour" from="${0..23}" value="${formatDate(date: workdayUnit.date1, format: 'HH', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>:<g:select name="fromMinute" from="${['00','15','30','45']}" value="${workdayUnit.date1.getMinutes()}"/></td>
      </tr>
      <tr>
        <td><g:message code="to"/>:</td>
        <td><g:select name="toHour" from="${0..23}" value="${formatDate(date: workdayUnit.date2, format: 'HH', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>:<g:select name="toMinute" from="${['00','15','30','45']}" value="${workdayUnit.date2.getMinutes()}"/></td>
      </tr>
      <tr>
        <td><g:message code="category"/>:</td>
        <td><g:select from="${workdaycategories}" name="category" value="${WorkdayCategory.findByName(workdayUnit.category)}"/></td>
      </tr>
      <tr>
        <td><g:message code="description"/>:</td>
        <td><g:textArea rows="3" cols="50" name="description" value="${workdayUnit.description.decodeHTML()}"/></td>
      </tr>
    </table>

    <div class="spacer"></div>
    <g:submitButton name="button" value="${message(code:'change')}"/>
    <div class="spacer"></div>
  </g:formRemote>