<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Betreiber anlegen</title>
  </head>
  <body>
    <div class="headerBlue">
      <h1>Betreiber anlegen</h1>
    </div>
  <div class="boxGray">
      <div class="body">
            <g:hasErrors bean="${entityInstance}">
              <div class="errors">
                <g:renderErrors bean="${entityInstance}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="saveOperator" method="post" id="${entityInstance.id}" params="[entity:entity.name]">
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

                    <p class="bold">Zusätzliche Angaben</p>

                    <table id="msg-composer">
                      <tbody>

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
                                    <label for="description">
                                      <g:message code="msg.description.label" default="Beschreibung" />:
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:entityInstance,field:'description','errors')}">
                                    <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
                                    <fckeditor:editor name="description" id="description" width="500px" height="400" toolbar="Post" fileBrowser="default">
                                      ${entityInstance?.profile?.description}
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
                        <g:submitButton name="submitButton" value="Anlegen" />
                        <g:link class="buttonGray" controller="profile" action="showProfile" params="[name:entity.name]">Abbrechen</g:link>
                        <div class="spacer"></div>
                    </div>
            </g:form>
        </div>
    </div>
    </body>
</html>