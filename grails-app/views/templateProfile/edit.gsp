<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.edit" args="[message(code: 'activityTemplate')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'activityTemplate')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: template]"/>

    <g:form id="${template.id}" params="[name:currentEntity.name]">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean:template,field:'profile.fullName','errors')}" size="50" name="fullName" value="${fieldValue(bean:template,field:'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="duration"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean:template,field:'profile.duration','errors')}" size="10" name="duration" value="${fieldValue(bean:template,field:'profile.duration')}"/> <span class="gray">(min)</span>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="activityTemplate.socialForm"/></td>
          <td valign="top" class="value">
            <g:select name="socialForm" from="['open','single','partner','smallgroup1','smallgroup2','smallgroup3','largegroup1','largegroup2']" value="${template?.profile?.socialForm}" valueMessagePrefix="socialForm"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="status"/></td>
          <td valign="top" class="value">
            <g:select name="status" from="['done','notDone','notDoneOpen']" value="${template?.profile?.status}" valueMessagePrefix="status"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="activityTemplate.amountEducators"/></td>
          <td valign="top" class="value">
            <g:select name="amountEducators" from="${1..5}" value="${template?.profile?.amountEducators}"/> <span class="gray">(Vorschlag)</span>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="activityTemplate.ageFrom"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean:template,field:'profile.ageFrom','errors')}" size="5" name="ageFrom" value="${fieldValue(bean:template,field:'profile.ageFrom').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="activityTemplate.ageTo"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean:template,field:'profile.ageTo','errors')}" size="5" name="ageTo" value="${fieldValue(bean:template,field:'profile.ageTo').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="description" height="200px" toolbar="Basic">
              ${fieldValue(bean:template,field:'profile.description').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="activityTemplate.chosenMaterials"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="chosenMaterials" height="200px" toolbar="Basic">
              ${fieldValue(bean:template,field:'profile.chosenMaterials').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="activityTemplate.goal"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="goal" height="200px" toolbar="Basic">
              ${fieldValue(bean:template,field:'profile.goal').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>