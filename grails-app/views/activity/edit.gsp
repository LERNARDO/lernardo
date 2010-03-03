  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Aktivität bearbeiten</title>
  </head>
  <body>
    <div class="headerBlue">
      <h1>Aktivität bearbeiten</h1>
    </div>
    <div class="boxGray">

      <g:hasErrors bean="${activityInstance}">
        <div class="errors">
          <g:renderErrors bean="${activityInstance}" as="list" />
        </div>
      </g:hasErrors>

      <g:form action="update" method="post" id="${activityInstance.id}">
        <table>
            <tbody>

%{--              <tr>
                <td class="label">Vorlage:</td>
                <td class="value"><${fieldValue(bean:activityInstance, field:'template')}"/></td>
              </tr>--}%

              <tr>
                <td class="label">Titel:</td>
                <td class="value ${hasErrors(bean:activityInstance,field:'profile.fullName','errors')}"><g:textField name="profile.fullName" size="30" value="${fieldValue(bean:activityInstance, field:'profile.fullName')}"/></td>
              </tr>

              <tr>
                <td class="label">Datum:</td>
                <td class="value ${hasErrors(bean:activityInstance,field:'profile.date','errors')}"><g:datePicker name="date" value="${activityInstance.profile.date}" precision="minute"/></td>
              </tr>

              <tr>
                <td class="label">Dauer:</td>
                <td class="value ${hasErrors(bean:activityInstance,field:'profile.duration','errors')}"><g:textField name="duration" size="30" value="${fieldValue(bean:activityInstance, field:'profile.duration')}"/> (in Minuten)</td>
              </tr>

              <tr>
                <td class="label">Einrichtung:</td>
                <td class="value ${hasErrors(bean:activityInstance,field:'facility','errors')}">
                  <g:select name="facility" from="${availFacilities}" optionKey="key" optionValue="value"/>
                </td>
              </tr>

              %{--TODO: highlight currently selected paeds and figure out why it only works with at least 2 paeds selected--}%
              <tr>
                <td class="label">Pädagogen:</td>
                <td class="value ${hasErrors(bean:activityInstance,field:'paeds','errors')}">
                  <g:select multiple="true" optionKey="key" optionValue="value" from="${availPaeds}" name="paeds"/>
                  <br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere PädagogInnen ausgewählt werden</p>
                </td>
              </tr>

              %{--TODO: highlight currently selected clients and figure out why it only works with at least 2 clients selected--}%
              <tr>
                <td class="label">Betreute:</td>
                <td class="value ${hasErrors(bean:activityInstance,field:'clients','errors')}">
                  <g:select multiple="true" optionKey="key" optionValue="value" from="${availClients}" name="clients"/>
                  <br/><p class="gray">Durch Drücken und Halten der STRG-Taste können mehrere Betreute ausgewählt werden</p>
                </td>
              </tr>

            </tbody>
        </table>

        <div class="buttons">
            <g:submitButton name="submitButton" value="Ändern" />
            <g:link class="buttonGray" action="show" id="${activityInstance.id}" params="[name:currentEntity.name]">Abbrechen</g:link>
            <div class="spacer"></div>
        </div>
        
      </g:form>

    </div>
  </body>