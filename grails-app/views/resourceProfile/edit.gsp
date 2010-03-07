<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Ressource bearbeiten</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Ressource bearbeiten</h1>
  </div>
  <div class="boxGray">
    <div class="body">
            <g:hasErrors bean="${resourceProfileInstance}">
            <div class="errors">
                <g:renderErrors bean="${resourceProfileInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${resourceProfileInstance?.id}" />
                <input type="hidden" name="version" value="${resourceProfileInstance?.version}" />
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
                                    <input type="text" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean:resourceProfileInstance,field:'profile.fullName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description">
                                    <g:message code="resourceProfile.description.label" default="Beschreibung" />
                                  </label>

                                </td>
                                <td valign="top" class="value ${hasErrors(bean:resourceProfileInstance,field:'description','errors')}">
                                    <textarea rows="5" cols="40" name="description">${fieldValue(bean:resourceProfileInstance, field:'profile.description')}</textarea>
                                </td>
                            </tr> 

                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Aktualisieren" /></span>
                    <g:link class="buttonGray" action="del" id="${resourceProfileInstance?.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
                     <g:link class="buttonGray" action="show" id="${resourceProfileInstance?.id}">Zurück</g:link>  
                  <div class="spacer"></div>
                </div>
            </g:form>
        </div>
    </div>
    </body>
