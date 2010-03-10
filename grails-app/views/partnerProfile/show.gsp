<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Partner</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Partner</h1>
  </div>
  <div class="boxGray">
    <div class="body">
            <div class="dialog">
                <table class="listing">
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="partnerProfile.fullName.label" default="Name" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:partner, field:'profile.fullName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="partnerProfile.description.label" default="Beschreibung" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:partner, field:'profile.description') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="partnerProfile.PLZ.label" default="PLZ" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:partner, field:'profile.PLZ') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="partnerProfile.city.label" default="Stadt" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:partner, field:'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="partnerProfile.street.label" default="Straße" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:partner, field:'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="partnerProfile.tel.label" default="Telefon" />:
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean:partner, field:'profile.tel') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
                            
                        </tr>

              <ub:isAdmin>
                <tr class="prop">
                    <td valign="top" class="name">
                       <g:message code="parentProfile.work.label" default="Aktiv?" />:
                    </td>

                    <td valign="top" class="value">${fieldValue(bean:parent, field:'user.enabled')}</td>

                </tr>
              </ub:isAdmin>
                    
                    </tbody>
                </table>
            </div>
      <div class="buttons">
         <g:link class="buttonBlue" action="edit" id="${partner?.id}">Bearbeiten</g:link>
         <g:link class="buttonGray" action="del" id="${partner?.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
         <g:link class="buttonGray" action="list">Zurück</g:link>
         <div class="spacer"></div>
       </div>
   </div>
 </div>
 </body>
