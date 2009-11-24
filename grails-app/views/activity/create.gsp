<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Aktivität anlegen</title>
  </head>
  <body>
      <div class="body">
            <h1>Aktivität anlegen</h1>
            <g:hasErrors bean="${activityInstance}">
              <div class="errors">
                <g:renderErrors bean="${activityInstance}" as="list" />
              </div>
            </g:hasErrors>
            <p>Vorlage: <g:link controller="template" action="show" id="${template.id}">${template.name}</g:link></p>
            <g:form action="save" method="post" id="${activityInstance.id}" params="[template:template.name]">
                    <h1>Notwendige Angaben</h1>
                    <table id="msg-composer">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title">
                                      <g:message code="msg.title.label" default="Titel" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:activityInstance,field:'title','errors')}">
                                    <input type="text" size="50" id="title" name="title" value="${fieldValue(bean:activityInstance,field:'title')}"/>
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
                                    <input type="text" size="50" id="duration" name="duration" value="${fieldValue(bean:activityInstance,field:'duration')}"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>

                    <div class="buttons">
                        <span class="button"><g:actionSubmit class="save" action="save" value="Anlegen" /></span>
                        <span class="nav-button"><g:link controller="template" action="list">Abbrechen</g:link></span>
                    </div>
            </g:form>
        </div>
    </body>
</html>