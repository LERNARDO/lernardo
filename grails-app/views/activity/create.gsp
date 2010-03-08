<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Aktivität anlegen</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Neue Aktivität anlegen</h1>
  </div>
  <div class="boxGray">

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
            <td class="label">Titel:</td>
            <td class="value ${hasErrors(bean:activityInstance,field:'profile.fullName','errors')}"><g:textField name="fullName" size="30" value="${fieldValue(bean:activityInstance, field:'profile.fullName')}"/></td>
          </tr>

          <tr>
            <td class="label">Datum:</td>
            <td class="value ${hasErrors(bean:activityInstance,field:'profile.date','errors')}"><g:datePicker name="date" value="${new Date()}" precision="minute"/></td>
          </tr>

          <tr>
            <td class="label">Dauer:</td>
            <td class="value ${hasErrors(bean:activityInstance,field:'profile.duration','errors')}"><g:textField name="duration" size="30" value="${fieldValue(bean:activityInstance, field:'profile.duration')}"/> (in Minuten)</td>
          </tr>

          <tr>
            <td class="label">Einrichtung:</td>
            <td class="value">
              <g:select name="facility" from="${availFacilities}" optionKey="id" optionValue="profile"/>
            </td>
          </tr>

          <tr>
            <td class="label">Pädagogen:</td>
            <td class="value">
              <g:select multiple="true" optionKey="id" optionValue="profile" from="${availPaeds}" name="paeds"/>
              <br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere PädagogInnen ausgewählt werden</p>
            </td>
          </tr>

          <tr>
            <td class="label">Betreute:</td>
            <td class="value">
              <g:select multiple="true" optionKey="id" optionValue="profile" from="${availClients}" name="clients"/>
              <br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere Betreute ausgewählt werden</p>
            </td>
          </tr>

        </tbody>
      </table>

      <div class="buttons">
          <g:submitButton name="submitButton" value="Anlegen" />
          <g:link class="buttonGray" controller="template" action="show" id="${template.id}">Abbrechen</g:link>
          <div class="spacer"></div>
      </div>

    </g:form>

  </div>
</body>