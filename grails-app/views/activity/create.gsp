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

    <g:hasErrors bean="${activityInstance}">
      <div class="errors">
        <g:renderErrors bean="${activityInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">

      <table>
        <tr class="prop">

           Aktivitätsvorlage: <g:select name="template" from="${templates}" optionKey="id" optionValue="profile"/>


          <td valign="top" class="name">
            <label for="fullName">
              <g:message code="activityInstance.profile.name"/>
            </label>
          </td>
          <td valign="top" class="name">
            <label for="startDate">
              <g:message code="activityInstance.profile.startDate"/>
            </label>
          </td>
          <td valign="top" class="name">
            <label for="endDate">
              <g:message code="activityInstance.profile.endDate"/>
            </label>
          </td>
        </tr>
        <tr>
          <td width="300" valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: activityInstance, field: 'fullName', 'errors')}" size="40" id="fullName" name="fullName" value="${fieldValue(bean: activityInstance, field: 'profile.fullName')}"/>
          </td>
          <td width="230" valign="top" class="value">
            <g:textField name="periodStart" size="30" class="datepicker" value="${activityInstance?.profile?.periodStart?.format('dd. MM. yyyy')}"/>
            %{--<g:datePicker name="periodStart" value="${activityInstance?.profile?.periodStart}" precision="day"/>--}%
            %{--<g:datePicker name="startDate" value="${activityInstance?.profile?.startDate}" precision="day"/>--}%
          </td>
          <td width="230" valign="top" class="value">
            <g:textField name="periodEnd" size="30" class="datepicker" value="${activityInstance?.profile?.periodEnd?.format('dd. MM. yyyy')}"/>
            %{--<g:datePicker name="periodEnd" value="${activityInstance?.profile?.periodEnd}" precision="day"/>--}%
            %{--<g:datePicker name="endDate" value="${activityInstance?.profile?.endDate}" precision="day"/>--}%
          </td>
        </tr>
        <tr>
          <td class="label"><g:message code="facility"/>:</td>
          <td class="label"><g:message code="educator"/>:</td>
          <td class="label"><g:message code="resource"/>:</td>
        </tr>
        <tr>
          <td class="value">
            <g:select class="drop-down-220" name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
          </td>
          <td class="value">
            <g:select   multiple="true" optionKey="id" optionValue="profile" from="${educators}" name="educators"/>
            <!--<br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere PädagogInnen ausgewählt werden</p>-->
          </td>
          <td class="value">
            <g:select multiple="true" optionKey="id" optionValue="profile" from="${resources}" name="resources"/>
            <!--<br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere Resourcen ausgewählt werden</p>   -->
          </td>
        </tr>
      </table>


      <table>
        <tr>
          <td colspan="7" width="80" class="label"><g:message code="activityInstance.profile.days"/></td>
        </tr>
        <tr>
          <td class="activityInstance-top" width="105"><g:message code="wd.mon.short"/> : &nbsp;
            <g:checkBox name="monday" value="${activityInstance?.monday}"/><br/>
            <g:select name="mondayStartHour" from="${0..23}" value="${activityInstance?.mondayStartHour}"/>:<g:select name="mondayStartMinute" from="${0..59}" value="${activityInstance?.mondayStartMinute}"/><br/>
            <g:select name="mondayEndHour" from="${0..23}" value="${activityInstance?.mondayStartHour}"/>:<g:select name="mondayEndMinute" from="${0..59}" value="${activityInstance?.mondayStartMinute}"/><br/>

            %{--<g:select name="mondayEndHour" from="${0..23}" value="${activityInstance?.mondayEndHour}"/>:<g:select name="mondayEndMinute" from="${0..59}" value="${activityInstance?.mondayEndMinute}"/>--}%
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.tue.short"/> : &nbsp;
            <g:checkBox name="tuesday" value="${activityInstance?.tuesday}"/><br/>
            <g:select name="tuesdayStartHour" from="${0..23}" value="${activityInstance?.tuesdayStartHour}"/>:<g:select name="tuesdayStartMinute" from="${0..59}" value="${activityInstance?.tuesdayStartMinute}"/><br/>
            <g:select name="tuesdayEndHour" from="${0..23}" value="${activityInstance?.tuesdayStartHour}"/>:<g:select name="tuesdayEndMinute" from="${0..59}" value="${activityInstance?.tuesdayStartMinute}"/><br/>
            %{--<g:select name="tuesdayEndHour" from="${0..23}" value="${activityInstance?.tuesdayEndHour}"/>:<g:select name="tuesdayEndMinute" from="${0..59}" value="${activityInstance?.tuesdayEndMinute}"/>--}%
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.wed.short"/> : &nbsp;
            <g:checkBox name="wednesday" value="${activityInstance?.wednesday}"/><br/>
            <g:select name="wednesdayStartHour" from="${0..23}" value="${activityInstance?.wednesdayStartHour}"/>:<g:select name="wednesdayStartMinute" from="${0..59}" value="${activityInstance?.wednesdayStartMinute}"/><br/>
            <g:select name="wednesdayEndHour" from="${0..23}" value="${activityInstance?.wednesdayStartHour}"/>:<g:select name="wednesdayEndMinute" from="${0..59}" value="${activityInstance?.wednesdayStartMinute}"/><br/>
            %{--<g:select name="wednesdayEndHour" from="${0..23}" value="${activityInstance?.wednesdayEndHour}"/>:<g:select name="wednesdayEndMinute" from="${0..59}" value="${activityInstance?.wednesdayEndMinute}"/>--}%
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.thu.short"/> : &nbsp;
            <g:checkBox name="thursday" value="${activityInstance?.thursday}"/><br/>
            <g:select name="thursdayStartHour" from="${0..23}" value="${activityInstance?.thursdayStartHour}"/>:<g:select name="thursdayStartMinute" from="${0..59}" value="${activityInstance?.thursdayStartMinute}"/><br/>
            <g:select name="thursdayEndHour" from="${0..23}" value="${activityInstance?.thursdayStartHour}"/>:<g:select name="thursdayEndMinute" from="${0..59}" value="${activityInstance?.thursdayStartMinute}"/><br/>
            %{--<g:select name="thursdayEndHour" from="${0..23}" value="${activityInstance?.thursdayEndHour}"/>:<g:select name="thursdayEndMinute" from="${0..59}" value="${activityInstance?.thursdayEndMinute}"/>--}%
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.fri.short"/> : &nbsp;
            <g:checkBox name="friday" value="${activityInstance?.friday}"/><br/>
            <g:select name="fridayStartHour" from="${0..23}" value="${activityInstance?.fridayStartHour}"/>:<g:select name="fridayStartMinute" from="${0..59}" value="${activityInstance?.fridayStartMinute}"/><br/>
            <g:select name="fridayEndHour" from="${0..23}" value="${activityInstance?.fridayStartHour}"/>:<g:select name="fridayEndMinute" from="${0..59}" value="${activityInstance?.fridayStartMinute}"/><br/>
            %{--<g:select name="fridayEndHour" from="${0..23}" value="${activityInstance?.fridayEndHour}"/>:<g:select name="fridayEndMinute" from="${0..59}" value="${activityInstance?.fridayEndMinute}"/>--}%
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.sat.short"/> : &nbsp;
            <g:checkBox name="saturday" value="${activityInstance?.saturday}"/><br/>
            <g:select name="saturdayStartHour" from="${0..23}" value="${activityInstance?.saturdayStartHour}"/>:<g:select name="saturdayStartMinute" from="${0..59}" value="${activityInstance?.saturdayStartMinute}"/><br/>
            <g:select name="saturdayEndHour" from="${0..23}" value="${activityInstance?.saturdayStartHour}"/>:<g:select name="saturdayEndMinute" from="${0..59}" value="${activityInstance?.saturdayStartMinute}"/><br/>
            %{--<g:select name="saturdayEndHour" from="${0..23}" value="${activityInstance?.saturdayEndHour}"/>:<g:select name="saturdayEndMinute" from="${0..59}" value="${activityInstance?.saturdayEndMinute}"/>--}%
          </td>
          <td class="activityInstance-top" width="105"><g:message code="wd.sun.short"/> : &nbsp;
            <g:checkBox name="tuesday" value="${activityInstance?.tuesday}"/><br/>
            <g:select name="sundayStartHour" from="${0..23}" value="${activityInstance?.sundayStartHour}"/>:<g:select name="sundayStartMinute" from="${0..59}" value="${activityInstance?.sundayStartMinute}"/><br/>
            <g:select name="sundayEndHour" from="${0..23}" value="${activityInstance?.sundayStartHour}"/>:<g:select name="sundayEndMinute" from="${0..59}" value="${activityInstance?.sundayStartMinute}"/><br/>
            %{--<g:select name="sundayEndHour" from="${0..23}" value="${activityInstance?.sundayEndHour}"/>:<g:select name="sundayEndMinute" from="${0..59}" value="${activityInstance?.sundayEndMinute}"/>--}%
          </td>
        </tr>
      </table>
     <p> </p>


      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" controller="activity" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>

  </div>
</div>
</body>