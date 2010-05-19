<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Themenraumaktivitäten anlegen</title>
</head>
<body>
  <div class="headerBlue">
    <div class="second">
      <h1>Themenraumaktivitäten planen</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">

      <g:hasErrors bean="${activityInstance}">
        <div class="errors">
          <g:renderErrors bean="${activityInstance}" as="list" />
        </div>
      </g:hasErrors>

      <p>Vorlage: <g:link controller="template" action="show" id="${template.id}">${template.profile.fullName}</g:link></p>
      <g:form action="save" method="post" id="${template.id}">
        <table>
          <tbody>

            <tr>
              <td class="label">Name:</td>
              <td class="value ${hasErrors(bean:activityInstance,field:'profile.fullName','errors')}"><g:textField name="fullName" size="40" value="${fieldValue(bean:activityInstance, field:'profile.fullName')}"/></td>
            </tr>

            <tr>
              <td class="label">Zeitraum:</td>
              <td class="value">Von: <g:datePicker name="periodStart" value="${new Date()}" precision="day"/> Bis: <g:datePicker name="periodEnd" value="${new Date()}" precision="day"/></td>
            </tr>

            <tr>
              <td class="label">Dauer:</td>
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
                      <g:checkBox name="monday" value="${activityInstance?.monday}"/><br/>
                      <g:select name="mondayStartHour" from="${0..23}" value="${activityInstance?.mondayStartHour}"/>:<g:select name="mondayStartMinute" from="${0..59}" value="${activityInstance?.mondayStartMinute}"/><br/>
                      <g:select name="mondayEndHour" from="${0..23}" value="${activityInstance?.mondayEndHour}"/>:<g:select name="mondayEndMinute" from="${0..59}" value="${activityInstance?.mondayEndMinute}"/>
                    </td>
                    <td>
                      <g:checkBox name="tuesday" value="${activityInstance?.tuesday}"/><br/>
                      <g:select name="tuesdayStartHour" from="${0..23}" value="${activityInstance?.tuesdayStartHour}"/>:<g:select name="tuesdayStartMinute" from="${0..59}" value="${activityInstance?.tuesdayStartMinute}"/><br/>
                      <g:select name="tuesdayEndHour" from="${0..23}" value="${activityInstance?.tuesdayEndHour}"/>:<g:select name="tuesdayEndMinute" from="${0..59}" value="${activityInstance?.tuesdayEndMinute}"/>
                    </td>
                    <td>
                      <g:checkBox name="wednesday" value="${activityInstance?.wednesday}"/><br/>
                      <g:select name="wednesdayStartHour" from="${0..23}" value="${activityInstance?.wednesdayStartHour}"/>:<g:select name="wednesdayStartMinute" from="${0..59}" value="${activityInstance?.wednesdayStartMinute}"/><br/>
                      <g:select name="wednesdayEndHour" from="${0..23}" value="${activityInstance?.wednesdayEndHour}"/>:<g:select name="wednesdayEndMinute" from="${0..59}" value="${activityInstance?.wednesdayEndMinute}"/>
                    </td>
                    <td>
                      <g:checkBox name="thursday" value="${activityInstance?.thursday}"/><br/>
                      <g:select name="thursdayStartHour" from="${0..23}" value="${activityInstance?.thursdayStartHour}"/>:<g:select name="thursdayStartMinute" from="${0..59}" value="${activityInstance?.thursdayStartMinute}"/><br/>
                      <g:select name="thursdayEndHour" from="${0..23}" value="${activityInstance?.thursdayEndHour}"/>:<g:select name="thursdayEndMinute" from="${0..59}" value="${activityInstance?.thursdayEndMinute}"/>
                    </td>
                    <td>
                      <g:checkBox name="friday" value="${activityInstance?.friday}"/><br/>
                      <g:select name="fridayStartHour" from="${0..23}" value="${activityInstance?.fridayStartHour}"/>:<g:select name="fridayStartMinute" from="${0..59}" value="${activityInstance?.fridayStartMinute}"/><br/>
                      <g:select name="fridayEndHour" from="${0..23}" value="${activityInstance?.fridayEndHour}"/>:<g:select name="fridayEndMinute" from="${0..59}" value="${activityInstance?.fridayEndMinute}"/>
                    </td>
                    <td>
                      <g:checkBox name="saturday" value="${activityInstance?.saturday}"/><br/>
                      <g:select name="saturdayStartHour" from="${0..23}" value="${activityInstance?.saturdayStartHour}"/>:<g:select name="saturdayStartMinute" from="${0..59}" value="${activityInstance?.saturdayStartMinute}"/><br/>
                      <g:select name="saturdayEndHour" from="${0..23}" value="${activityInstance?.saturdayEndHour}"/>:<g:select name="saturdayEndMinute" from="${0..59}" value="${activityInstance?.saturdayEndMinute}"/>
                    </td>
                    <td>
                      <g:checkBox name="tuesday" value="${activityInstance?.tuesday}"/><br/>
                      <g:select name="sundayStartHour" from="${0..23}" value="${activityInstance?.sundayStartHour}"/>:<g:select name="sundayStartMinute" from="${0..59}" value="${activityInstance?.sundayStartMinute}"/><br/>
                      <g:select name="sundayEndHour" from="${0..23}" value="${activityInstance?.sundayEndHour}"/>:<g:select name="sundayEndMinute" from="${0..59}" value="${activityInstance?.sundayEndMinute}"/>
                    </td>
                  </tr>
                </table>
            </tr>

            <tr>
              <td class="label">Einrichtung:</td>
              <td class="value">
                <g:select name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
              </td>
            </tr>

            <tr>
              <td class="label">Pädagogen:</td>
              <td class="value">
                <g:select multiple="true" optionKey="id" optionValue="profile" from="${educators}" name="educators"/>
                <br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere PädagogInnen ausgewählt werden</p>
              </td>
            </tr>

            <tr>
              <td class="label">Ressourcen:</td>
              <td class="value">
                <g:select multiple="true" optionKey="id" optionValue="profile" from="${resources}" name="resources"/>
                <br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere Resourcen ausgewählt werden</p>
              </td>
            </tr>

%{--            <tr>
              <td class="label">Betreute:</td>
              <td class="value">
                <g:select multiple="true" optionKey="id" optionValue="profile" from="${clients}" name="clients"/>
                <br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere Betreute ausgewählt werden</p>
              </td>
            </tr>--}%

          </tbody>
        </table>

        <div class="buttons">
            <g:submitButton name="submitButton" value="Speichern" />
            <g:link class="buttonGray" controller="template" action="show" id="${template.id}">Abbrechen</g:link>
            <div class="spacer"></div>
        </div>

      </g:form>

    </div>
  </div>
</body>