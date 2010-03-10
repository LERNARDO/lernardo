<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Betreiber</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Betreiber</h1>
  </div>
  <div class="boxGray">
    <div class="body">
      <div class="dialog">
        <table class="listing">
          <tbody>
                    
            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="operatorProfile.fullName.label" default="Name" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:operator, field:'profile.fullName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="operatorProfile.PLZ.label" default="PLZ" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:operator, field:'profile.PLZ') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="operatorProfile.description.label" default="Beschreibung" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:operator, field:'profile.description') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="operatorProfile.city.label" default="Stadt" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:operator, field:'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="operatorProfile.showTips.label" default="Zeige Tipps" />:
                </td>

                <td valign="top" class="value"><app:showBoolean bool="${operator.profile.showTips}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="operatorProfile.street.label" default="Straße" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:operator, field:'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="operatorProfile.tel.label" default="Telefon" />:
                </td>

                <td valign="top" class="value">${fieldValue(bean:operator, field:'profile.tel') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

            </tr>

      </tbody>
    </table>
  </div>
  <div class="buttons">
     <g:link class="buttonBlue" action="edit" id="${operator?.id}">Bearbeiten</g:link>
     <g:link class="buttonGray" action="del" id="${operator?.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
     <g:link class="buttonGray" action="list">Zurück</g:link>
     <div class="spacer"></div>
   </div>
 </div>
 </div>
 </body>