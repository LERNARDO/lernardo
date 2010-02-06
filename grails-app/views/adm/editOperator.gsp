<head>
  <title>Lernardo | Profildaten ändern</title>
</head>
<body>
  <h3>Profildaten ändern</h3>

  <g:hasErrors bean="${entityInstance}">
    <div class="errors">
      <g:renderErrors bean="${entityInstance}" as="list" />
    </div>
  </g:hasErrors>

  <g:form action="updateOperator" method="post" id="${entityInstance.id}">
    <table class="table">
      <tbody>

        <tr>
          <td class="label">Name:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.fullName','errors')}"><g:textField name="fullName" size="40" value="${fieldValue(bean:entityInstance, field:'profile.fullName')}"/></td>
        </tr>

        <tr>
          <td class="label">PLZ:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.PLZ','errors')}"><g:textField name="PLZ" size="5" value="${entityInstance.profile.PLZ}"/></td>
        </tr>

        <tr>
          <td class="label">Stadt:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.city','errors')}"><g:textField name="city" size="40" value="${fieldValue(bean:entityInstance, field:'profile.city')}"/></td>
        </tr>

        <tr>
          <td class="label">Straße:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.street','errors')}"><g:textField name="street" size="40" value="${fieldValue(bean:entityInstance, field:'profile.street').decodeHTML()}"/></td>
        </tr>

        <tr>
          <td class="label">Telefon:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.tel','errors')}"><g:textField name="tel" size="40" value="${fieldValue(bean:entityInstance, field:'profile.tel')}"/></td>
        </tr>

        <tr>
          <td class="label">Beschreibung:</td>
          <td class="value ${hasErrors(bean:entityInstance,field:'profile.description','errors')}">
            <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
            <fckeditor:editor name="description" id="description" width="500" height="400" toolbar="Post" fileBrowser="default">
              ${entityInstance?.profile?.description}
            </fckeditor:editor>
          </td>
        </tr>

        <tr>
          <td class="topic">Tipps anzeigen:</td>
          <td><g:checkBox name="showTips" value="${entityInstance.profile.showTips}" /></td>
        </tr>

      </tbody>
    </table>

    <div class="buttons table">
        <g:submitButton name="submitButton" value="Ändern" />
        <g:link action="overview">Abbrechen</g:link>
        <div class="spacer"></div>
    </div>

  </g:form>
</body>