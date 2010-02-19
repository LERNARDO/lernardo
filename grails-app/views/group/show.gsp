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
          <td class="label">Name:</td>
          <td class="value">${fieldValue(bean:groupInstance, field:'name')}</td>
        </tr>

        <tr>
          <td class="label">Beschreibung:</td>
          <td class="value">${fieldValue(bean:groupInstance, field:'description')}</td>
        </tr>

        <tr>
          <td class="label">Mitglieder:</td>
          <td class="value">
            <ul>
              <g:each var="m" in="${groupInstance.members}">
                  <li><g:link controller="profile" action="showProfile" params="[name: m.name]">${m?.profile?.fullName?.encodeAsHTML()}</g:link></li>
              </g:each>
            </ul>
          </td>
        </tr>
                    
      </tbody>
    </table>

    <div class="buttons">
      <g:link class="buttonGray" controller="profile" action="showProfile" params="[name:entity.name]">zurück</g:link>
      <div class="spacer"></div>
    </div>

  </div>
</body>
