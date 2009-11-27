<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Betreiber anlegen</title>
  </head>
  <body>
      <div class="body">
            <h1>Betreiber anlegen</h1>
            <g:hasErrors bean="${entityInstance}">
              <div class="errors">
                <g:renderErrors bean="${entityInstance}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="save" method="post" id="${entityInstance.id}">
                    <p class="bold">Notwendige Angaben</p>
                    <table id="msg-composer">
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fullName">
                                      <g:message code="msg.fullName.label" default="Name" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="text" size="50" id="fullName" name="fullName" value="${fieldValue(bean:entityInstance,field:'profile.fullName')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">
                                      <g:message code="msg.name.label" default="Kurzname" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'name','errors')}">
                                    <input type="text" size="50" id="name" name="name" value="${fieldValue(bean:entityInstance,field:'name')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">
                                      <g:message code="msg.email.label" default="Email" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'email','errors')}">
                                    <input type="text" size="50" id="email" name="email" value="${fieldValue(bean:entityInstance, field:'profile.email')}"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <p class="bold">Zusätzliche Angaben</p>

                    <table id="msg-composer">
                      <tbody>

                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city">
                                      <g:message code="msg.city.label" default="Stadt" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'city','errors')}">
                                    <input type="text" size="50" id="city" name="city" value="${fieldValue(bean:entityInstance, field:'profile.city')}"/>
                                </td>
                            </tr>

                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">
                                      <g:message code="msg.description.label" default="Beschreibung" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'description','errors')}">
                                    <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                                    <fckeditor:editor name="description" id="description" width="550px" height="400" toolbar="Post" fileBrowser="default">
                                      ${entityInstance.profile.description}
                                    </fckeditor:editor>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                    <div class="buttons">
                        <span class="button"><g:actionSubmit class="save" action="saveOperator" value="Anlegen" /></span>
                        <span class="nav-button"><g:link controller="admin" action="index">Abbrechen</g:link></span>
                    </div>
            </g:form>
        </div>
    </body>
</html>