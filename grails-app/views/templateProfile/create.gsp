<head>
  <meta name="layout" content="private"/>
  <title>Aktivitätsvorlage anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Aktivitätsvorlage anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${template}">
      <div class="errors">
        <g:renderErrors bean="${template}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">

      <div class="dialog">
        <table>
          <tr class="prop">
            <td colspan="3" valign="top" class="name">Typ:</td>
          </tr>
          <tr>
            <td colspan="3" valign="top" class="name">
              <g:select id="type" name="type" from="${['normale Aktivitätsvorlage','Themenraumaktivitätsvorlage']}" value="${template?.profile?.type}"/>
            </td>
          </tr>
          <tr class="prop">
            <td colspan="2" valign="top" class="name">
              <label for="fullName"><g:message code="activityTemplate.name"/>:</label>
            </td>
            <td valign="top" class="name">
              <label for="duration"><g:message code="activityTemplate.duration"/>:</label>
            </td>
          </tr>

          <tr>
            <td colspan="2" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean:template,field:'profile.fullName','errors')}" size="51" id="fullName" name="fullName" value="${fieldValue(bean:template,field:'profile.fullName')}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean:template,field:'profile.duration','errors')}" size="20" id="duration" name="duration" value="${fieldValue(bean:template,field:'profile.duration')}"/> (in Minuten)
            </td>
          </tr>

          <tr class="prop">
            <td width="210px" valign="top" class="name">
              <label for="socialForm"><g:message code="activityTemplate.socialForm"/>:</label>
            </td>
            <td width="190px" valign="top" class="name">
              <label for="status"><g:message code="activityTemplate.status"/>:</label>
            </td>
            <td valign="top" class="name">
              <label for="amountEducators"><g:message code="activityTemplate.amountEducators"/>:</label>
            </td>
          </tr>

          <tr>
            <td valign="top" class="value  ${hasErrors(bean: template, field: 'profile.socialForm', 'errors')}">
              <g:select id="socialForm" name="socialForm" from="${['offen','Einzelarbeit','Partnerarbeit','Kleingruppe (bis 5 Kinder)','Kleingruppe (4-8 Kinder)','Kleingruppe (bis 8 Kinder)','Großgruppe (bis 15 Kinder)','Großgruppe (bis 25 Kinder)']}" value="${fieldValue(bean:template,field:'profile.socialForm')}"/>
            </td>
            <td valign="top" class="value  ${hasErrors(bean: template, field: 'profile.status', 'errors')}">
              <g:select id="status" name="status" from="${['fertig','in Bearbeitung']}" value="${template?.profile?.status}"/>
            </td>
            <td valign="top" class="value  ${hasErrors(bean: template, field: 'profile.amountEducators', 'errors')}">
              <g:select id="amountEducators" name="amountEducators" from="${1..5}" value="${template?.profile?.amountEducators}"/> (Vorschlag)
            </td>
          </tr>

          <tr class="prop">
            <td colspan="2" valign="top" class="name">
              <label for="description"><g:message code="activityTemplate.description"/>:</label>
            </td>
            <td valign="top" class="name">
              <label for="chosenMaterials"><g:message code="activityTemplate.chosenMaterials"/>:</label>
            </td>
          </tr>

          <tr>
            <td colspan="2" valign="top" class="value ${hasErrors(bean: template, field: 'profile.description', 'errors')}">
              <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
              <fckeditor:editor name="description" id="description" width="390" height="400" toolbar="Basic" fileBrowser="default">
                ${template?.profile?.description}
              </fckeditor:editor>
            </td>
            <td valign="top" class="value ${hasErrors(bean: template, field: 'profile.chosenMaterials', 'errors')}">
              <fckeditor:config CustomConfigurationsPath="${g.resource(dir:'js', file: 'fck-config.js').toString()}"/>
              <fckeditor:editor name="chosenMaterials" id="chosenMaterials" width="390" height="400" toolbar="Basic" fileBrowser="default">
                ${template?.profile?.chosenMaterials}
              </fckeditor:editor>
            </td>
          </tr>

        </table>
      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" controller="templateProfile" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
