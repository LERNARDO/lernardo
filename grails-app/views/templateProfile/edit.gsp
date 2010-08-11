<head>
  <meta name="layout" content="private"/>
  <title>Aktivitätsvorlage bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Aktivitätsvorlage bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: template]"/>

    <g:form action="update" method="post" id="${template.id}">
      <table>

        <tr class="prop">
          <td colspan="3" valign="top" class="name">Typ:</td>
        </tr>

        <tr>
          <td colspan="3" valign="top" class="value">
            <g:select id="type" name="type" from="${['normale Aktivitätsvorlage','Themenraumaktivitätsvorlage']}" value="${template?.profile?.type}"/>
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name"><g:message code="activityTemplate.name"/>:</td>
          <td valign="top" class="name"><g:message code="activityTemplate.duration"/>:</td>
        </tr>

        <tr>
          <td colspan="2" valign="top" class="value">
            <g:textField class="countable${template.profile.constraints.fullName.maxSize} ${hasErrors(bean:template,field:'profile.fullName','errors')}" size="51" name="fullName" value="${fieldValue(bean:template,field:'profile.fullName').decodeHTML()}"/>
          </td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean:template,field:'profile.duration','errors')}" size="20" name="duration" value="${fieldValue(bean:template,field:'profile.duration')}"/> (in Minuten)
          </td>
        </tr>

        <tr class="prop">
          <td width="210px" valign="top" class="name"><g:message code="activityTemplate.socialForm"/>:</td>
          <td width="190px" valign="top" class="name"><g:message code="activityTemplate.status"/>:</td>
          <td valign="top" class="name"><g:message code="activityTemplate.amountEducators"/>:</td>
        </tr>

        <tr>
          <td valign="top" class="value  ${hasErrors(bean: template, field: 'profile.socialForm', 'errors')}">
            <g:select name="socialForm" from="${['offen','Einzelarbeit','Partnerarbeit','Kleingruppe (bis 5 Kinder)','Kleingruppe (4-8 Kinder)','Kleingruppe (bis 8 Kinder)','Großgruppe (bis 15 Kinder)','Großgruppe (bis 25 Kinder)']}" value="${fieldValue(bean:template,field:'profile.socialForm')}"/>
          </td>
          <td valign="top" class="value  ${hasErrors(bean: template, field: 'profile.status', 'errors')}">
            <g:select name="status" from="${['fertig','in Bearbeitung']}" value="${template?.profile?.status}"/>
          </td>
          <td valign="top" class="value  ${hasErrors(bean: template, field: 'profile.amountEducators', 'errors')}">
            <g:select name="amountEducators" from="${1..5}" value="${template?.profile?.amountEducators}"/> (Vorschlag)
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name"><g:message code="activityTemplate.description"/>:</td>
          <td valign="top" class="name"><g:message code="activityTemplate.chosenMaterials"/>:</td>
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

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonRed" action="del" id="${template.id}" onclick="${app.getLinks(id: template.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${template.id}" params="[name:currentEntity.name]"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>