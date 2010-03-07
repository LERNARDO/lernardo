<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Ressource anlegen</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Ressource anlegen</h1>
  </div>
  <div class="boxGray">
    <div class="body">
            <g:hasErrors bean="${resourceProfileInstance}">
            <div class="errors">
                <g:renderErrors bean="${resourceProfileInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fullName">
                                      <g:message code="resourceProfile.fullName.label" default="Name" />
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:resourceProfileInstance,field:'fullName','errors')}">
                                    <input type="text" size="50" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean:resourceProfileInstance,field:'fullName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">
                                      <g:message code="resourceProfile.description.label" default="Beschreibung" />
                                    </label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:resourceProfileInstance,field:'description','errors')}">
                                    <textarea rows="5" cols="70" name="description">${fieldValue(bean:resourceProfileInstance, field:'description')}</textarea>
                                </td>
                            </tr> 

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Anlegen" /></span>
                    <g:link class="buttonGray" action="list">Zurück</g:link>
                    <div class="spacer"></div>
                </div>
            </g:form>
        </div>
    </div>
    </body>
