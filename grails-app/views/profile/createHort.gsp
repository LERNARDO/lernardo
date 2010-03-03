<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Hort anlegen</title>
  </head>
  <body>
      <div class="headerBlue">
      <h1>Hort anlegen</h1>
    </div>
  <div class="boxGray">
      <div class="body">
            <g:hasErrors bean="${entityInstance}">
              <div class="errors">
                <g:renderErrors bean="${entityInstance}" as="list" />
              </div>
            </g:hasErrors>
            <g:form action="saveHort" method="post" id="${entityInstance.id}" params="[entity:entity.name]">
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

                            <ub:isAdmin>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="operator">
                                      <g:message code="msg.operator.label" default="Betreiber" />:
                                    </label>
                                </td>
                                <td valign="top" class="value">
                                  <g:select name="operator" from="${availOperators}" optionKey="id" optionValue="name"/>
                                </td>
                            </tr>
                            </ub:isAdmin>

                        </tbody>
                    </table>

                    <h1>Zusätzliche Angaben</h1>

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