<head>
  <meta name="layout" content="private"/>
  <title><g:message code="activityInstance"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="activityInstance"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: ac]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="activityInstance.profile.name"/></td>
          <td valign="top" class="name"><g:message code="activityInstance.profile.startDate"/></td>
          <td valign="top" class="name"><g:message code="activityInstance.profile.endDate"/></td>
        </tr>

        <tr>
          <td width="380" valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: ac, field: 'fullName', 'errors')}" size="40" name="fullName" value="${fieldValue(bean: ac, field: 'fullName').decodeHTML()}"/>
          </td>
          <td width="200" valign="top" class="value">
            %{--
            <g:textField name="periodStart" size="10" class="datepicker ${hasErrors(bean: ac, field: 'periodStart', 'errors')}" value="${formatDate(date: ac?.periodStart, format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
            --}%
            <g:textField name="periodStart" size="10" class="datepicker ${hasErrors(bean: ac, field: 'periodStart', 'errors')}" value="${formatDate(date: ac?.periodStart, format: 'dd. MM. yyyy')}"/>
          </td>
          <td valign="top" class="value">
            %{--
            <g:textField name="periodEnd" size="10" class="datepicker ${hasErrors(bean: ac, field: 'periodEnd', 'errors')}" value="${formatDate(date: ac?.periodEnd, format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
            --}%
            <g:textField name="periodEnd" size="10" class="datepicker ${hasErrors(bean: ac, field: 'periodEnd', 'errors')}" value="${formatDate(date: ac?.periodEnd, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

      </table>

      <div style="border-bottom: 1px solid #ccc; margin-bottom: 10px; padding-bottom: 5px">
        <g:message code="activityTemplate"/>

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField1" update="remoteTemplates" action="remoteTemplates" before="showspinner('#remoteTemplates')"/>
        <div id="remoteTemplates"></div>

        <div style="visibility: hidden">
          <g:textField name="template" id="hiddentextfield1" value="default"/>
        </div>

        <div id="templates2">
        </div>
      </div>

      <div style="border-bottom: 1px solid #ccc; margin-bottom: 10px; padding-bottom: 5px">
        <g:message code="facility"/>

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField2" update="remoteFacilities" action="remoteFacilities" before="showspinner('#remoteFacilities')"/>
        <div id="remoteFacilities"></div>

        <div style="visibility: hidden">
          <g:textField name="facility" id="hiddentextfield2" value="default"/>
        </div>

        <div id="facilities2">
        </div>
      </div>

      %{--<td class="label"><g:message code="resources"/>:</td>--}%
      %{--<td class="value" valign="top"><g:select class="drop-down-220 ${hasErrors(bean: ac, field: 'facility', 'errors')}" name="facility" from="${facilities}" optionKey="id" optionValue="profile"/></td>--}%
      %{--<td class="value"><g:select multiple="true" optionKey="id" optionValue="profile" from="${resources}" name="resources"/></td>--}%

      <p><g:message code="educators"/>: (<g:message code="selectFacility"/>)</p>
      <span id="educators">
        <g:render template="educatorsOld" model="[educators: ac?.educators, currentEntity: currentEntity]"/>
      </span>


      <table width="100%" class="${hasErrors(bean: ac, field: 'weekdays', 'errors')}">
        <tr>
          <td colspan="7" class="label"><g:message code="chooseDay"/></td>
        </tr>
        <tr>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="monday" value="${ac?.monday}"/> <g:message code="monday"/></div>
            <g:select name="mondayStartHour" from="${0..23}" value="${ac?.mondayStartHour}"/>:<g:select name="mondayStartMinute" from="${0..59}" value="${ac?.mondayStartMinute}"/><br/>
            <g:select name="mondayEndHour" from="${0..23}" value="${ac?.mondayEndHour}"/>:<g:select name="mondayEndMinute" from="${0..59}" value="${ac?.mondayEndMinute}"/><br/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="tuesday" value="${ac?.tuesday}"/> <g:message code="tuesday"/></div>
            <g:select name="tuesdayStartHour" from="${0..23}" value="${ac?.tuesdayStartHour}"/>:<g:select name="tuesdayStartMinute" from="${0..59}" value="${ac?.tuesdayStartMinute}"/><br/>
            <g:select name="tuesdayEndHour" from="${0..23}" value="${ac?.tuesdayEndHour}"/>:<g:select name="tuesdayEndMinute" from="${0..59}" value="${ac?.tuesdayEndMinute}" format="mm"/><br/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="wednesday" value="${ac?.wednesday}"/> <g:message code="wednesday"/></div>
            <g:select name="wednesdayStartHour" from="${0..23}" value="${ac?.wednesdayStartHour}"/>:<g:select name="wednesdayStartMinute" from="${0..59}" value="${ac?.wednesdayStartMinute}"/><br/>
            <g:select name="wednesdayEndHour" from="${0..23}" value="${ac?.wednesdayEndHour}"/>:<g:select name="wednesdayEndMinute" from="${0..59}" value="${ac?.wednesdayEndMinute}"/><br/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="thursday" value="${ac?.thursday}"/> <g:message code="thursday"/></div>
            <g:select name="thursdayStartHour" from="${0..23}" value="${ac?.thursdayStartHour}"/>:<g:select name="thursdayStartMinute" from="${0..59}" value="${ac?.thursdayStartMinute}"/><br/>
            <g:select name="thursdayEndHour" from="${0..23}" value="${ac?.thursdayEndHour}"/>:<g:select name="thursdayEndMinute" from="${0..59}" value="${ac?.thursdayEndMinute}"/><br/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="friday" value="${ac?.friday}"/> <g:message code="friday"/></div>
            <g:select name="fridayStartHour" from="${0..23}" value="${ac?.fridayStartHour}"/>:<g:select name="fridayStartMinute" from="${0..59}" value="${ac?.fridayStartMinute}"/><br/>
            <g:select name="fridayEndHour" from="${0..23}" value="${ac?.fridayEndHour}"/>:<g:select name="fridayEndMinute" from="${0..59}" value="${ac?.fridayEndMinute}"/><br/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="saturday" value="${ac?.saturday}"/> <g:message code="saturday"/></div>
            <g:select name="saturdayStartHour" from="${0..23}" value="${ac?.saturdayStartHour}"/>:<g:select name="saturdayStartMinute" from="${0..59}" value="${ac?.saturdayStartMinute}"/><br/>
            <g:select name="saturdayEndHour" from="${0..23}" value="${ac?.saturdayEndHour}"/>:<g:select name="saturdayEndMinute" from="${0..59}" value="${ac?.saturdayEndMinute}"/><br/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="sunday" value="${ac?.sunday}"/> <g:message code="sunday"/></div>
            <g:select name="sundayStartHour" from="${0..23}" value="${ac?.sundayStartHour}"/>:<g:select name="sundayStartMinute" from="${0..59}" value="${ac?.sundayStartMinute}"/><br/>
            <g:select name="sundayEndHour" from="${0..23}" value="${ac?.sundayEndHour}"/>:<g:select name="sundayEndMinute" from="${0..59}" value="${ac?.sundayEndMinute}"/><br/>
          </td>
        </tr>
      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>

  </div>
</div>
</body>