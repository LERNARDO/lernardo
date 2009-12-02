<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Pädagoge anlegen</title>
  </head>
  <body>
      <div class="body">
            <h1>Pädagoge anlegen</h1>
            <g:hasErrors bean="${entityInstance}">
              <div class="errors">
                <g:renderErrors bean="${entityInstance}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="save" method="post" id="${entityInstance.id}" params="[entity:entity.name]">
                    <h1>Notwendige Angaben</h1>
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
                                    <input type="text" size="10" id="name" name="name" value="${fieldValue(bean:entityInstance,field:'name')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">
                                      <g:message code="msg.email.label" default="Email" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'email','errors')}">
                                    <input type="text" size="30" id="email" name="email" value="${fieldValue(bean:entityInstance, field:'profile.email')}"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <h1>Zusätzliche Angaben</h1>

                    <table id="msg-composer">
                      <tbody>

                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title">
                                      <g:message code="msg.city.label" default="Titel" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'title','errors')}">
                                    <input type="text" size="10" id="title" name="title" value="${fieldValue(bean:entityInstance, field:'profile.title')}"/>
                                </td>
                            </tr>

                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="birthDate">
                                      <g:message code="msg.birthDate.label" default="Geburtstag" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'birthDate','errors')}">
                                    <g:datePicker name="birthDate" id="birthDate" value="${fieldValue(bean:entityInstance, field:'profile.birthDate')}" precision="day"/>
                                </td>
                            </tr>

                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="PLZ">
                                      <g:message code="msg.PLZ.label" default="PLZ" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'PLZ','errors')}">
                                    <input type="text" size="5" id="PLZ" name="PLZ" value="${fieldValue(bean:entityInstance, field:'profile.PLZ')}"/>
                                </td>
                            </tr>

                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city">
                                      <g:message code="msg.city.label" default="Stadt" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'city','errors')}">
                                    <input type="text" size="30" id="city" name="city" value="${fieldValue(bean:entityInstance, field:'profile.city')}"/>
                                </td>
                            </tr>

                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="street">
                                      <g:message code="msg.street.label" default="Straße" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'street','errors')}">
                                    <input type="text" size="40" id="street" name="street" value="${fieldValue(bean:entityInstance, field:'profile.street')}"/>
                                </td>
                            </tr>

                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tel">
                                      <g:message code="msg.tel.label" default="Telefon" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'tel','errors')}">
                                    <input type="text" size="20" id="tel" name="tel" value="${fieldValue(bean:entityInstance, field:'profile.tel')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gender">
                                      <g:message code="msg.gender.label" default="Geschlecht" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'tel','errors')}">
                                    <g:select id="gender" name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:entityInstance, field:'profile.gender')}" optionKey="key" optionValue="value"/>
                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="biography">
                                      <g:message code="msg.biography.label" default="Biographie" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'biography','errors')}">
                                    <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                                    <fckeditor:editor name="biography" id="biography" width="500px" height="400" toolbar="Post" fileBrowser="default">
                                      ${entityInstance?.profile?.biography}
                                    </fckeditor:editor>
                                </td>
                            </tr>

                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pass">
                                      <g:message code="msg.pass.label" default="Passwort" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'pass','errors')}">
                                    <input type="text" size="20" id="pass" name="pass" value="${fieldValue(bean:entityInstance, field:'user.password')}"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                    <div class="buttons">
                        <span class="button"><g:actionSubmit class="save" action="savePaed" value="Anlegen" /></span>
                        <span class="nav-button"><g:link controller="profile" action="showProfile" params="[name:entity.name]">Abbrechen</g:link></span>
                    </div>
            </g:form>
        </div>
    </body>
</html>