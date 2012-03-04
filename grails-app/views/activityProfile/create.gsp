<head>
  <meta name="layout" content="planning"/>
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
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="name"><g:message code="begin"/></td>
          <td valign="top" class="name"><g:message code="end"/></td>
        </tr>

        <tr>
          <td width="380" valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: ac, field: 'fullName', 'errors')}" size="40" name="fullName" value="${fieldValue(bean: ac, field: 'fullName').decodeHTML()}"/>
          </td>
          <td width="200" valign="top" class="value">
            <g:textField name="periodStart" size="10" class="datepicker ${hasErrors(bean: ac, field: 'periodStart', 'errors')}" value="${formatDate(date: ac?.periodStart, format: 'dd. MM. yyyy')}"/>
          </td>
          <td valign="top" class="value">
            <g:textField name="periodEnd" size="10" class="datepicker ${hasErrors(bean: ac, field: 'periodEnd', 'errors')}" value="${formatDate(date: ac?.periodEnd, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

      </table>

      <div style="border-bottom: 1px solid #ccc; margin-bottom: 10px; padding-bottom: 5px">
        <g:message code="activityTemplate"/> <g:message code="search"/>:<br/>

        <g:remoteField size="40" name="remoteField1" update="remoteTemplates" action="remoteTemplates" before="showspinner('#remoteTemplates')"/>
        <div id="remoteTemplates"></div>

        <div style="visibility: hidden">
          <g:textField name="template" id="hiddentextfield1" value="default"/>
        </div>

        <div id="templates2">
        </div>
      </div>

      <div style="border-bottom: 1px solid #ccc; margin-bottom: 10px; padding-bottom: 5px">
        <g:message code="facility"/> <g:message code="search"/>:<br/>

        <g:remoteField size="40" name="remoteField2" update="remoteFacilities" action="remoteFacilities" before="showspinner('#remoteFacilities')"/>
        <div id="remoteFacilities"></div>

        <div style="visibility: hidden">
          <g:textField name="facility" id="hiddentextfield2" value="default"/>
        </div>

        <div id="facilities2">
        </div>
      </div>

      <p><g:message code="educators"/>:</p>
      <span id="educators">
        <p class="gray"><g:message code="selectFacility"/></p>
      </span>

      <p><g:message code="clients"/>:</p>
      <span id="clients">
        <p class="gray"><g:message code="selectFacility"/></p>
      </span>

      <table width="100%" class="${hasErrors(bean: ac, field: 'weekdays', 'errors')}">
        <tr>
          <td colspan="7" class="label"><g:message code="chooseDay"/></td>
        </tr>
        <tr>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="monday" value="${ac?.monday}"/> <g:message code="monday"/></div>
            <g:textField name="mondayStart" class="timepicker ${hasErrors(bean: ac, field: 'mondayStart', 'errors')}" size="4" value="${formatDate(date: ac?.mondayStart, format: 'HH:mm')}"/> - <g:textField name="mondayEnd" class="timepicker ${hasErrors(bean: ac, field: 'mondayEnd', 'errors')}" size="4" value="${formatDate(date: ac?.mondayEnd, format: 'HH:mm')}"/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="tuesday" value="${ac?.tuesday}"/> <g:message code="tuesday"/></div>
            <g:textField name="tuesdayStart" class="timepicker ${hasErrors(bean: ac, field: 'tuesdayStart', 'errors')}" size="4" value="${formatDate(date: ac?.tuesdayStart, format: 'HH:mm')}"/> - <g:textField name="tuesdayEnd" class="timepicker ${hasErrors(bean: ac, field: 'tuesdayEnd', 'errors')}" size="4" value="${formatDate(date: ac?.tuesdayEnd, format: 'HH:mm')}"/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="wednesday" value="${ac?.wednesday}"/> <g:message code="wednesday"/></div>
            <g:textField name="wednesdayStart" class="timepicker ${hasErrors(bean: ac, field: 'wednesdayStart', 'errors')}" size="4" value="${formatDate(date: ac?.wednesdayStart, format: 'HH:mm')}"/> - <g:textField name="wednesdayEnd" class="timepicker ${hasErrors(bean: ac, field: 'wednesdayEnd', 'errors')}" size="4" value="${formatDate(date: ac?.wednesdayEnd, format: 'HH:mm')}"/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="thursday" value="${ac?.thursday}"/> <g:message code="thursday"/></div>
            <g:textField name="thursdayStart" class="timepicker ${hasErrors(bean: ac, field: 'thursdayStart', 'errors')}" size="4" value="${formatDate(date: ac?.thursdayStart, format: 'HH:mm')}"/> - <g:textField name="thursdayEnd" class="timepicker ${hasErrors(bean: ac, field: 'thursdayEnd', 'errors')}" size="4" value="${formatDate(date: ac?.thursdayEnd, format: 'HH:mm')}"/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="friday" value="${ac?.friday}"/> <g:message code="friday"/></div>
            <g:textField name="fridayStart" class="timepicker ${hasErrors(bean: ac, field: 'fridayStart', 'errors')}" size="4" value="${formatDate(date: ac?.fridayStart, format: 'HH:mm')}"/> - <g:textField name="fridayEnd" class="timepicker ${hasErrors(bean: ac, field: 'fridayEnd', 'errors')}" size="4" value="${formatDate(date: ac?.fridayEnd, format: 'HH:mm')}"/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="saturday" value="${ac?.saturday}"/> <g:message code="saturday"/></div>
            <g:textField name="saturdayStart" class="timepicker ${hasErrors(bean: ac, field: 'saturdayStart', 'errors')}" size="4" value="${formatDate(date: ac?.saturdayStart, format: 'HH:mm')}"/> - <g:textField name="saturdayEnd" class="timepicker ${hasErrors(bean: ac, field: 'saturdayEnd', 'errors')}" size="4" value="${formatDate(date: ac?.saturdayEnd, format: 'HH:mm')}"/>
          </td>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="sunday" value="${ac?.sunday}"/> <g:message code="sunday"/></div>
            <g:textField name="sundayStart" class="timepicker ${hasErrors(bean: ac, field: 'sundayStart', 'errors')}" size="4" value="${formatDate(date: ac?.sundayStart, format: 'HH:mm')}"/> - <g:textField name="sundayEnd" class="timepicker ${hasErrors(bean: ac, field: 'sundayEnd', 'errors')}" size="4" value="${formatDate(date: ac?.sundayEnd, format: 'HH:mm')}"/>
          </td>
        </tr>
      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="clear"></div>
      </div>

    </g:form>

  </div>
</div>
</body>