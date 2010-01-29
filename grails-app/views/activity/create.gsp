<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Aktivität anlegen</title>
  </head>
  <body>
    <div class="headerBlue">
      <h1>Neue Aktivität planen</h1>
    </div>
  <div class="boxGray">
      <div class="body">
            <g:hasErrors bean="${activityInstance}">
              <div class="errors">
                <g:renderErrors bean="${activityInstance}" as="list" />
              </div>
            </g:hasErrors>
            <p>Vorlage: <g:link controller="template" action="show" id="${template.id}">${template.name}</g:link></p>
            <g:form method="post" action="save" id="${activityInstance.id}" params="[template:template.name]">
                    <table id="msg-composer">
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
                        <g:submitButton name="submitButton" value="Anlegen" />
                        <g:link class="buttonGray" controller="template" action="list">Abbrechen</g:link>
                        <div class="spacer"></div>
                    </div>

            </g:form>
        </div>
    </div>
    </body>
</html>