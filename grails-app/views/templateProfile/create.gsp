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

    <g:form>

      <div>
        <table width="100%">

          <tr class="prop">
            <td colspan="2" valign="top" class="name"><g:message code="activityTemplate.name"/>:</td>
            <td valign="top" class="name"><g:message code="activityTemplate.duration"/>:</td>
          </tr>

          <tr>
            <td colspan="2" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean:template,field:'profile.fullName','errors')}" size="50" name="fullName" value="${fieldValue(bean:template,field:'profile.fullName').decodeHTML()}"/>
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
              <g:select name="socialForm" from="['open','single','partner','smallgroup1','smallgroup2','smallgroup3','largegroup1','largegroup2']" value="${template?.profile?.socialForm}" valueMessagePrefix="socialForm"/>
            </td>
            <td valign="top" class="value  ${hasErrors(bean: template, field: 'profile.status', 'errors')}">
              <g:select name="status" from="['done','notDone']" value="${template?.profile?.status}" valueMessagePrefix="status"/>
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
              <ckeditor:editor name="description" height="200px" width="350px" toolbar="Basic">
                ${fieldValue(bean:template,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
            </td>
            <td valign="top" class="value ${hasErrors(bean: template, field: 'profile.chosenMaterials', 'errors')}">
              <ckeditor:editor name="chosenMaterials" height="200px" toolbar="Basic">
                ${fieldValue(bean:template,field:'profile.chosenMaterials').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="activityTemplate.ageFrom"/>:</td>
            <td valign="top" class="name"><g:message code="activityTemplate.ageTo"/>:</td>
            <td valign="top" class="name"><g:message code="activityTemplate.goal"/>:</td>
          </tr>

          <tr>
            <td valign="top">
              <g:textField class="${hasErrors(bean:template,field:'profile.ageFrom','errors')}" size="5" name="ageFrom" value="${fieldValue(bean:template,field:'profile.ageFrom').decodeHTML()}"/>
            </td>
            <td valign="top">
              <g:textField class="${hasErrors(bean:template,field:'profile.ageTo','errors')}" size="5" name="ageTo" value="${fieldValue(bean:template,field:'profile.ageTo').decodeHTML()}"/>
            </td>
            <td valign="top" class="value ${hasErrors(bean: template, field: 'profile.goal', 'errors')}">
              <ckeditor:editor name="goal" height="200px" toolbar="Basic">
                ${fieldValue(bean:template,field:'profile.goal').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

        </table>
      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
