<%@ page import="at.uenterprise.erp.Setup" %>
<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="educator.profile.workHours"/></title>
</head>
<body>

<div class="tabInactive">
    <h1><g:link controller="timeEvaluation"><g:message code="timeEvaluation"/></g:link></h1>
</div>

<div class="tabInactive">
    <h1><g:link controller="workdayCategory" action="index"><g:message code="privat.workdaycategories"/></g:link></h1>
</div>

<div class="tabActive">
    <h1><g:message code="educator.profile.workHours"/></h1>
</div>

<div class="clear"></div>

<div class="boxContent">

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'workdayUnit', action: 'showPersons']" update="result" before="showspinner('#result')">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="active"/></td>
          <td class="value">
            <g:checkBox name="active" value="true"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="type"/></td>
          <td class="value">
            <g:select name="type" from="['user','educator']" valueMessagePrefix="profiletype"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="educator.profile.employment"/></td>
          <td class="value">
            <g:select name="employment" from="${Setup.list()[0]?.employmentStatus}" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
      <div class="clear"></div>
    </g:formRemote>

  </div>

  <div id="result" style="margin-top: 10px;">
  </div>

</div>
</body>