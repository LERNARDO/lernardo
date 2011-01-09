<head>
  <meta name="layout" content="private"/>
  <title><g:message code="activityTemplate.create"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="activityTemplate.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: template]"/>

    <g:form action="save">

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
            <td colspan="2" valign="top" class="name"><g:message code="activityTemplate.name"/>:</td>
            <td valign="top" class="name"><g:message code="activityTemplate.duration"/>:</td>
          </tr>

          <tr>
            <td colspan="2" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean:template,field:'profile.fullName','errors')}" size="51" name="fullName" value="${fieldValue(bean:template,field:'profile.fullName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean:template,field:'profile.duration','errors')}" size="20" name="duration" value="${fieldValue(bean:template,field:'profile.duration')}"/> (min)
            </td>
          </tr>

          <tr class="prop">
            <td width="210px" valign="top" class="name"><g:message code="activityTemplate.socialForm"/>: </td>
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
              <ckeditor:editor name="description" height="300px" width="380px" toolbar="Basic">
                ${fieldValue(bean:template,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
            </td>
            <td valign="top" class="value ${hasErrors(bean: template, field: 'profile.chosenMaterials', 'errors')}">
              <ckeditor:editor name="chosenMaterials" height="300px" width="380px" toolbar="Basic">
                ${fieldValue(bean:template,field:'profile.chosenMaterials').decodeHTML()}
              </ckeditor:editor>
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
