<head>
  <title>Lernardo | Gruppe</title>
  <meta name="layout" content="private"/>
</head>
<body>
  <div class="headerBlue">
    <h1>Gruppe: ${groupInstance.name}</h1>
  </div>
  <div class="boxGray">
    <table>
      <tbody>

        <tr>
          <td class="bold">Name:</td>
          <td class="value">${fieldValue(bean:groupInstance, field:'profile.fullName')}</td>
        </tr>

        <tr>
          <td class="bold">Wohnverhältnisse:</td>
          <td class="value">${fieldValue(bean:groupInstance, field:'profile.livingConditions')}</td>
        </tr>

        <tr>
          <td class="bold">Personen im Haushalt:</td>
          <td class="value">${fieldValue(bean:groupInstance, field:'profile.personCount')}</td>
        </tr>

        <tr>
          <td class="bold">Familieneinkommen:</td>
          <td class="value">${fieldValue(bean:groupInstance, field:'profile.totalIncome')}</td>
        </tr>

        <tr>
          <td class="bold">Sonstige Daten:</td>
          <td class="value">${fieldValue(bean:groupInstance, field:'profile.otherData')}</td>
        </tr>
      
        <tr>
          <td class="bold">Mitglieder:</td>
          <td class="value">
            <ul>
              <app:getGroup entity="${groupInstance}">
                <g:each var="member" in="${members}">
                    <li><g:link controller="${member.type.supertype.name +'Profile'}" action="show" id="${member.id}">${member.profile.fullName}</g:link></li>
                </g:each>
              </app:getGroup>
            </ul>
          </td>
        </tr>
                    
      </tbody>
    </table>

    <div class="buttons">
      <g:link class="buttonGray" controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}">zurück</g:link>
      <div class="spacer"></div>
    </div>

  </div>
</body>
