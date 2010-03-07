<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Ressource</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Ressource</h1>
  </div>
  <div class="boxGray">
    <div class="body">
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="resourceProfile.fullName.label" default="Name" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:resourceProfileInstance, field:'profile.fullName')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="resourceProfile.description.label" default="Beschreibung" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:resourceProfileInstance, field:'profile.description')}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
              <g:link class="buttonBlue" action="edit" id="${resourceProfileInstance?.id}">Bearbeiten</g:link>
              <g:link class="buttonGray" action="del" id="${resourceProfileInstance?.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
              <g:link class="buttonGray" action="list">Zurück</g:link>
              <div class="spacer"></div>
            </div>
        </div>
    </div>
    </body>
