  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Aktivität bearbeiten</title>
  </head>
  <body>
    <div class="headerBlue">
      <h1>Aktivität bearbeiten</h1>
    </div>
    <div class="boxGray">

      <g:hasErrors bean="${activity}">
        <div class="errors">
          <g:renderErrors bean="${activity}" as="list" />
        </div>
      </g:hasErrors>

      <g:form action="update" method="post" id="${activity.id}">
        <table>
            <tbody>

              <tr>
                <td class="label">Vorlage:</td>
                <td class="value"><app:getTemplate entity="${activity}">
                  <g:link controller="template" action="show" id="${template.id}">${template.profile.fullName}</g:link>
                  </app:getTemplate>
                </td>
              </tr>

              <tr>
                <td class="label">Titel:</td>
                <td class="value ${hasErrors(bean:activity,field:'profile.fullName','errors')}"><g:textField name="profile.fullName" size="30" value="${fieldValue(bean:activity, field:'profile.fullName')}"/></td>
              </tr>

              <tr>
                <td class="label">Datum:</td>
                <td class="value ${hasErrors(bean:activity,field:'profile.date','errors')}"><g:datePicker name="date" value="${activity.profile.date}" precision="minute"/></td>
              </tr>

              <tr>
                <td class="label">Dauer:</td>
                <td class="value ${hasErrors(bean:activity,field:'profile.duration','errors')}"><g:textField name="duration" size="30" value="${fieldValue(bean:activity, field:'profile.duration')}"/> (in Minuten)</td>
              </tr>

              <tr>
                <td class="label">Einrichtung:</td>
                <td class="value ${hasErrors(bean:activity,field:'facility','errors')}">
                  <g:select name="facility" from="${availFacilities}" optionKey="id" optionValue="profile"/>
                </td>
              </tr>

              %{--TODO: highlight currently selected paeds--}%
              <tr>
                <td class="label">Pädagogen:</td>
                <td class="value ${hasErrors(bean:activity,field:'paeds','errors')}">
                  <g:select multiple="true" optionKey="id" optionValue="profile" from="${availPaeds}" name="paeds"/>
                  <br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere PädagogInnen ausgewählt werden</p>
                </td>
              </tr>

              %{--TODO: highlight currently selected clients--}%
              <tr>
                <td class="label">Betreute:</td>
                <td class="value ${hasErrors(bean:activity,field:'clients','errors')}">
                  <g:select multiple="true" optionKey="id" optionValue="profile" from="${availClients}" name="clients"/>
                  <br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere Betreute ausgewählt werden</p>
                </td>
              </tr>

            </tbody>
        </table>

        <div class="buttons">
            <g:submitButton name="submitButton" value="Ändern" />
            <g:link class="buttonGray" action="show" id="${activity.id}" params="[name:currentEntity.name]">Abbrechen</g:link>
            <div class="spacer"></div>
        </div>
        
      </g:form>

    </div>
  </body>