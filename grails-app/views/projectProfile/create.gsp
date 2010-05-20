<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Projekt anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Projekt anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <g:hasErrors bean="${project}">
      <div class="errors">
        <g:renderErrors bean="${project}" as="list"/>
      </div>
    </g:hasErrors>

    <p>Vorlage: <g:link controller="projectTemplateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link></p>
    <g:form action="save" method="post" id="${template.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="project.profile.name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: project, field: 'fullName', 'errors')}" size="40" id="fullName" name="fullName" value="${fieldValue(bean: project, field: 'profile.fullName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="startDate">
                <g:message code="project.profile.startDate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="startDate" value="${project?.profile?.startDate}" precision="day"/>
            </td>
          </tr>


          <tr class="prop">
            <td valign="top" class="name">
              <label for="endDate">
                <g:message code="project.profile.endDate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker name="endDate" value="${project?.profile?.endDate}" precision="day"/>
            </td>
          </tr>

          <tr>
              <td class="label">Beginn:</td>
              <td class="value">
                <table>
                  <tr>
                    <td>MO</td>
                    <td>DI</td>
                    <td>MI</td>
                    <td>DO</td>
                    <td>FR</td>
                    <td>SA</td>
                    <td>SO</td>
                  </tr>
                  <tr>
                    <td>
                      <g:checkBox name="monday" value="${project?.monday}"/><br/>
                      <g:select name="mondayStartHour" from="${0..23}" value="${project?.mondayStartHour}"/>:<g:select name="mondayStartMinute" from="${0..59}" value="${project?.mondayStartMinute}"/><br/>
                      %{--<g:select name="mondayEndHour" from="${0..23}" value="${project?.mondayEndHour}"/>:<g:select name="mondayEndMinute" from="${0..59}" value="${project?.mondayEndMinute}"/>--}%
                    </td>
                    <td>
                      <g:checkBox name="tuesday" value="${project?.tuesday}"/><br/>
                      <g:select name="tuesdayStartHour" from="${0..23}" value="${project?.tuesdayStartHour}"/>:<g:select name="tuesdayStartMinute" from="${0..59}" value="${project?.tuesdayStartMinute}"/><br/>
                      %{--<g:select name="tuesdayEndHour" from="${0..23}" value="${project?.tuesdayEndHour}"/>:<g:select name="tuesdayEndMinute" from="${0..59}" value="${project?.tuesdayEndMinute}"/>--}%
                    </td>
                    <td>
                      <g:checkBox name="wednesday" value="${project?.wednesday}"/><br/>
                      <g:select name="wednesdayStartHour" from="${0..23}" value="${project?.wednesdayStartHour}"/>:<g:select name="wednesdayStartMinute" from="${0..59}" value="${project?.wednesdayStartMinute}"/><br/>
                      %{--<g:select name="wednesdayEndHour" from="${0..23}" value="${project?.wednesdayEndHour}"/>:<g:select name="wednesdayEndMinute" from="${0..59}" value="${project?.wednesdayEndMinute}"/>--}%
                    </td>
                    <td>
                      <g:checkBox name="thursday" value="${project?.thursday}"/><br/>
                      <g:select name="thursdayStartHour" from="${0..23}" value="${project?.thursdayStartHour}"/>:<g:select name="thursdayStartMinute" from="${0..59}" value="${project?.thursdayStartMinute}"/><br/>
                      %{--<g:select name="thursdayEndHour" from="${0..23}" value="${project?.thursdayEndHour}"/>:<g:select name="thursdayEndMinute" from="${0..59}" value="${project?.thursdayEndMinute}"/>--}%
                    </td>
                    <td>
                      <g:checkBox name="friday" value="${project?.friday}"/><br/>
                      <g:select name="fridayStartHour" from="${0..23}" value="${project?.fridayStartHour}"/>:<g:select name="fridayStartMinute" from="${0..59}" value="${project?.fridayStartMinute}"/><br/>
                      %{--<g:select name="fridayEndHour" from="${0..23}" value="${project?.fridayEndHour}"/>:<g:select name="fridayEndMinute" from="${0..59}" value="${project?.fridayEndMinute}"/>--}%
                    </td>
                    <td>
                      <g:checkBox name="saturday" value="${project?.saturday}"/><br/>
                      <g:select name="saturdayStartHour" from="${0..23}" value="${project?.saturdayStartHour}"/>:<g:select name="saturdayStartMinute" from="${0..59}" value="${project?.saturdayStartMinute}"/><br/>
                      %{--<g:select name="saturdayEndHour" from="${0..23}" value="${project?.saturdayEndHour}"/>:<g:select name="saturdayEndMinute" from="${0..59}" value="${project?.saturdayEndMinute}"/>--}%
                    </td>
                    <td>
                      <g:checkBox name="tuesday" value="${project?.tuesday}"/><br/>
                      <g:select name="sundayStartHour" from="${0..23}" value="${project?.sundayStartHour}"/>:<g:select name="sundayStartMinute" from="${0..59}" value="${project?.sundayStartMinute}"/><br/>
                      %{--<g:select name="sundayEndHour" from="${0..23}" value="${project?.sundayEndHour}"/>:<g:select name="sundayEndMinute" from="${0..59}" value="${project?.sundayEndMinute}"/>--}%
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
