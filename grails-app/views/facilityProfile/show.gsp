<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Einrichtung</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Einrichtung</h1>
  </div>
  <div class="boxGray">
    <div class="body">
            <div class="dialog">
                <table>
                    <tbody>

                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="facilityProfile.fullName.label" default="Name" />:
                            </td>

                            <td valign="top" class="value">${fieldValue(bean:facility, field:'profile.fullName')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="facilityProfile.description.label" default="Beschreibung" />:
                            </td>

                            <td valign="top" class="value">${fieldValue(bean:facility, field:'profile.description')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="facilityProfile.PLZ.label" default="PLZ" />:
                            </td>

                            <td valign="top" class="value">${fieldValue(bean:facility, field:'profile.PLZ')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="facilityProfile.city.label" default="Stadt" />:
                            </td>

                            <td valign="top" class="value">${fieldValue(bean:facility, field:'profile.city')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="facilityProfile.street.label" default="Straße" />:
                            </td>

                            <td valign="top" class="value">${fieldValue(bean:facility, field:'profile.street')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="facilityProfile.tel.label" default="Telefon" />:
                            </td>

                            <td valign="top" class="value">${fieldValue(bean:facility, field:'profile.tel')}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">
                               <g:message code="facilityProfile.email.label" default="E-Mail" />:
                            </td>

                            <td valign="top" class="value">${fieldValue(bean:facility, field:'user.email')}</td>

                        </tr>

                    </tbody>
                </table>
            </div>
      <div class="buttons">
         <g:link class="buttonBlue" action="edit" id="${facility?.id}">Bearbeiten</g:link>
         <g:link class="buttonGray" action="del" id="${facility?.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
         <g:link class="buttonGray" action="list">Zurück</g:link>
         <div class="spacer"></div>
       </div>
   </div>
 </div>
 </body>
