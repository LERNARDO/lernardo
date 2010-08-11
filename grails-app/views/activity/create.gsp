<head>
  <meta name="layout" content="private"/>
  <title><g:message code="activityInstance"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="activityInstance"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${ac}">
      <div class="errors">
        <g:renderErrors bean="${ac}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">

      <table>

        <tr class="prop">

          Aktivitätsvorlage: <g:select name="template" from="${templates}" optionKey="id" optionValue="profile"/>

          <td valign="top" class="name"><g:message code="activityInstance.profile.name"/></td>
          <td valign="top" class="name"><g:message code="activityInstance.profile.startDate"/></td>
          <td valign="top" class="name"><g:message code="activityInstance.profile.endDate"/></td>
        </tr>

        <tr>
          <td width="300" valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: ac, field: 'fullName', 'errors')}" size="40" id="fullName" name="fullName" value="${fieldValue(bean: ac, field: 'fullName').decodeHTML()}"/>
          </td>
          <td width="230" valign="top" class="value">
            <g:textField name="periodStart" size="30" class="datepicker ${hasErrors(bean: ac, field: 'periodStart', 'errors')}" value="${ac?.periodStart?.format('dd. MM. yyyy')}"/>
          </td>
          <td width="230" valign="top" class="value">
            <g:textField name="periodEnd" size="30" class="datepicker ${hasErrors(bean: ac, field: 'periodEnd', 'errors')}" value="${ac?.periodEnd?.format('dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr>
          <td class="label"><g:message code="facility"/>:</td>
          <td class="label"><g:message code="educator"/>:</td>
          <td class="label"><g:message code="resource"/>:</td>
        </tr>

        <tr>
          <td class="value"><g:select class="drop-down-220" name="facility" from="${facilities}" optionKey="id" optionValue="profile"/></td>
          <td class="value"><g:select multiple="true" optionKey="id" optionValue="profile" from="${educators}" name="educators"/></td>
          <td class="value"><g:select multiple="true" optionKey="id" optionValue="profile" from="${resources}" name="resources"/></td>
        </tr>

      </table>

      <table class="${hasErrors(bean: ac, field: 'weekdays', 'errors')}">
        <tr>
          <td colspan="7" width="80" class="label"><g:message code="activityInstance.profile.days"/></td>
        </tr>
        <tr>
          <td class="activityInstance-top" width="105"><g:message code="wd.mon.short"/> : &nbsp;
            <g:checkBox name="monday" value="${ac?.monday}"/><br/>
            <g:select name="mondayStartHour" from="${0..23}" value="${ac?.mondayStartHour}"/>:<g:select name="mondayStartMinute" from="${0..59}" value="${ac?.mondayStartMinute}"/><br/>
            <g:select name="mondayEndHour" from="${0..23}" value="${ac?.mondayEndHour}"/>:<g:select name="mondayEndMinute" from="${0..59}" value="${ac?.mondayEndMinute}"/><br/>
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.tue.short"/> : &nbsp;
            <g:checkBox name="tuesday" value="${ac?.tuesday}"/><br/>
            <g:select name="tuesdayStartHour" from="${0..23}" value="${ac?.tuesdayStartHour}"/>:<g:select name="tuesdayStartMinute" from="${0..59}" value="${ac?.tuesdayStartMinute}"/><br/>
            <g:select name="tuesdayEndHour" from="${0..23}" value="${ac?.tuesdayEndHour}"/>:<g:select name="tuesdayEndMinute" from="${0..59}" value="${ac?.tuesdayEndMinute}"/><br/>
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.wed.short"/> : &nbsp;
            <g:checkBox name="wednesday" value="${ac?.wednesday}"/><br/>
            <g:select name="wednesdayStartHour" from="${0..23}" value="${ac?.wednesdayStartHour}"/>:<g:select name="wednesdayStartMinute" from="${0..59}" value="${ac?.wednesdayStartMinute}"/><br/>
            <g:select name="wednesdayEndHour" from="${0..23}" value="${ac?.wednesdayEndHour}"/>:<g:select name="wednesdayEndMinute" from="${0..59}" value="${ac?.wednesdayEndMinute}"/><br/>
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.thu.short"/> : &nbsp;
            <g:checkBox name="thursday" value="${ac?.thursday}"/><br/>
            <g:select name="thursdayStartHour" from="${0..23}" value="${ac?.thursdayStartHour}"/>:<g:select name="thursdayStartMinute" from="${0..59}" value="${ac?.thursdayStartMinute}"/><br/>
            <g:select name="thursdayEndHour" from="${0..23}" value="${ac?.thursdayEndHour}"/>:<g:select name="thursdayEndMinute" from="${0..59}" value="${ac?.thursdayEndMinute}"/><br/>
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.fri.short"/> : &nbsp;
            <g:checkBox name="friday" value="${ac?.friday}"/><br/>
            <g:select name="fridayStartHour" from="${0..23}" value="${ac?.fridayStartHour}"/>:<g:select name="fridayStartMinute" from="${0..59}" value="${ac?.fridayStartMinute}"/><br/>
            <g:select name="fridayEndHour" from="${0..23}" value="${ac?.fridayEndHour}"/>:<g:select name="fridayEndMinute" from="${0..59}" value="${ac?.fridayEndMinute}"/><br/>
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.sat.short"/> : &nbsp;
            <g:checkBox name="saturday" value="${ac?.saturday}"/><br/>
            <g:select name="saturdayStartHour" from="${0..23}" value="${ac?.saturdayStartHour}"/>:<g:select name="saturdayStartMinute" from="${0..59}" value="${ac?.saturdayStartMinute}"/><br/>
            <g:select name="saturdayEndHour" from="${0..23}" value="${ac?.saturdayEndHour}"/>:<g:select name="saturdayEndMinute" from="${0..59}" value="${ac?.saturdayEndMinute}"/><br/>
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.sun.short"/> : &nbsp;
            <g:checkBox name="sunday" value="${ac?.sunday}"/><br/>
            <g:select name="sundayStartHour" from="${0..23}" value="${ac?.sundayStartHour}"/>:<g:select name="sundayStartMinute" from="${0..59}" value="${ac?.sundayStartMinute}"/><br/>
            <g:select name="sundayEndHour" from="${0..23}" value="${ac?.sundayEndHour}"/>:<g:select name="sundayEndMinute" from="${0..59}" value="${ac?.sundayEndMinute}"/><br/>
          </td>
        </tr>
      </table>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" controller="activity" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>

  </div>
</div>
</body>