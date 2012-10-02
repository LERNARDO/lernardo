<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.edit" args="[message(code: 'activityTemplate')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'activityTemplate')]"/></h1>
</div>
<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: template]"/>

    <g:form id="${template.id}" params="[name:currentEntity.name]">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean:template,field:'profile.fullName','errors')}" required="" size="50" name="fullName" value="${fieldValue(bean:template,field:'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="duration"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField class="${hasErrors(bean:template,field:'profile.duration','errors')}" required="" size="10" name="duration" value="${fieldValue(bean:template,field:'profile.duration')}"/> <span class="gray">(min)</span>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="activityTemplate.socialForm"/></td>
          <td class="value">
            <g:select name="socialForm" from="${grailsApplication.config.socialForms}" value="${template?.profile?.socialForm}" valueMessagePrefix="socialForm"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="status"/></td>
          <td class="value">
            <g:select name="status" from="['done','notDone','notDoneOpen']" value="${template?.profile?.status}" valueMessagePrefix="status"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="activityTemplate.amountEducators"/></td>
          <td class="value">
            <g:select name="amountEducators" from="${1..5}" value="${template?.profile?.amountEducators}"/> <span class="gray">(<g:message code="suggestion"/>)</span>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="activityTemplate.ageFrom"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean:template,field:'profile.ageFrom','errors')}" size="5" name="ageFrom" value="${fieldValue(bean:template,field:'profile.ageFrom').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="activityTemplate.ageTo"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean:template,field:'profile.ageTo','errors')}" size="5" name="ageTo" value="${fieldValue(bean:template,field:'profile.ageTo').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <ckeditor:editor name="description" height="200px" toolbar="Basic">
              ${fieldValue(bean:template,field:'profile.description').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="activityTemplate.chosenMaterials"/></td>
          <td class="value">
            <ckeditor:editor name="chosenMaterials" height="200px" toolbar="Basic">
              ${fieldValue(bean:template,field:'profile.chosenMaterials').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="activityTemplate.goal"/></td>
          <td class="value">
            <ckeditor:editor name="goal" height="200px" toolbar="Basic">
              ${fieldValue(bean:template,field:'profile.goal').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="show" id="${template.id}"><g:message code="cancel"/></g:link></div>
      </div>

    </g:form>

</div>
</body>