<head>
  <title>Lernardo | Betreiber anlegen</title>
</head>

<body>
  <h3>Betreiber anlegen</h3>

  <g:hasErrors bean="${entityInstance}">
    <div class="errors">
      <g:renderErrors bean="${entityInstance}" as="list" />
    </div>
  </g:hasErrors>

  <g:form action="saveOperator" method="post" id="${entityInstance.id}">
    <p class="bold">Notwendige Angaben</p>
    <table class="table">
      <tbody>

        <tr>
          <td class="label">Name:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.fullName','errors')}"><g:textField name="fullName" size="40" value="${fieldValue(bean:entityInstance, field:'profile.fullName')}"/></td>
        </tr>

        <tr>
          <td class="label">Kurzname:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'name','errors')}"><g:textField name="name" size="40" value="${fieldValue(bean:entityInstance, field:'name')}"/></td>
        </tr>

        <tr>
          <td class="label">E-Mail:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.email','errors')}"><g:textField name="email" size="40" value="${fieldValue(bean:entityInstance, field:'profile.email')}"/></td>
        </tr>

      </tbody>
    </table>

    <p class="bold">Zusätzliche Angaben</p>

    <table class="table">
      <tbody>

        <tr>
          <td class="label">PLZ:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.PLZ','errors')}"><g:textField name="PLZ" size="5" value="${fieldValue(bean:entityInstance, field:'profile.PLZ')}"/></td>
        </tr>

        <tr>
          <td class="label">Stadt:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.city','errors')}"><g:textField name="city" size="40" value="${fieldValue(bean:entityInstance, field:'profile.city')}"/></td>
        </tr>

        <tr>
          <td class="label">Straße:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.street','errors')}"><g:textField name="street" size="40" value="${fieldValue(bean:entityInstance, field:'profile.street')}"/></td>
        </tr>

        <tr>
          <td class="label">Telefon:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.tel','errors')}"><g:textField name="tel" size="40" value="${fieldValue(bean:entityInstance, field:'profile.tel')}"/></td>
        </tr>

        <tr>
          <td class="label">Beschreibung:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.description','errors')}">
            <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
            <fckeditor:editor name="description" id="description" width="500" height="400" toolbar="Post" fileBrowser="default">
              ${entityInstance?.profile?.description}
            </fckeditor:editor>
          </td>
        </tr>

        <tr>
          <td class="label">Passwort:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'user.password','errors')}"><g:textField name="pass" size="20" value="${fieldValue(bean:entityInstance, field:'user.password')}"/></td>
        </tr>

      </tbody>
    </table>

    <div class="buttons table">
        <g:submitButton name="submitButton" value="Anlegen" />
        <g:link action="overview">Abbrechen</g:link>
    </div>

  </g:form>
</body>