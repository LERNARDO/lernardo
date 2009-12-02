  <head>
    <meta name="layout" content="private" />
    <title>Aktivitätsvorlage bearbeiten</title>
  </head>
  <body>
        <div class="body">
            <h1>Aktivitätsvorlage bearbeiten</h1>
            <g:hasErrors bean="${activityInstance}">
              <div class="errors">
                <g:renderErrors bean="${activityInstance}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="update" method="post" id="${activityInstance.id}">
                    <table>
                        <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="title">
                                  <g:message code="msg.title.label" default="Titel" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:activityInstance,field:'title','errors')}">
                                <input type="text" size="40" id="title" name="title" value="${fieldValue(bean:activityInstance,field:'title')}"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="date">
                                  <g:message code="msg.date.label" default="Datum" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:activityInstance,field:'date','errors')}">
                                <g:datePicker name="date" id="date" value="${new Date()}" precision="minute"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="duration">
                                  <g:message code="msg.duration.label" default="Dauer" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:activityInstance,field:'duration','errors')}">
                                <input type="text" size="10" id="duration" name="duration" value="${fieldValue(bean:activityInstance,field:'duration')}"/> (min)
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="facility">
                                  <g:message code="msg.facility.label" default="Einrichtung" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:activityInstance,field:'facility','errors')}">
                                <g:select id="facility" name="facility.id" from="${hortList}" optionKey="id" optionValue="name" value="${activityInstance?.facility?.id}"/>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="paeds">
                                  <g:message code="msg.paeds.label" default="Pädagogen" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:activityInstance,field:'paeds','errors')}">
                              <g:select multiple="true" optionKey="id" optionValue="name"
                                      from="${availPaeds}"
                                      name="paeds"
                                      value="${activityInstance?.paeds?.collect{it.id}}" ></g:select>
                              <br/><span class="gray">Es können mehrere Pädagogen mit STRG ausgewählt werden</span>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                                <label for="clients">
                                  <g:message code="msg.clients.label" default="Betreute" />:
                                </label>
                            </td>
                            <td valign="top" class="value ${hasErrors(bean:activityInstance,field:'clients','errors')}">
                              <g:select multiple="true" optionKey="id" optionValue="name"
                                      from="${availClients}"
                                      name="clients"
                                      value="${activityInstance?.clients?.collect{it.id}}" ></g:select>
                              <br/><span class="gray">Es können mehrere Betreute mit STRG ausgewählt werden</span>
                            </td>
                        </tr>

                        </tbody>
                    </table>

                    <div class="buttons">
                        <span class="button"><g:actionSubmit class="save" action="update" value="Ändern" /></span>
                        <span class="nav-button"><g:link action="show" id="${activityInstance.id}" params="[name:currentEntity.name]">Abbrechen</g:link></span>
                    </div>
            </g:form>
        </div>
  </body>