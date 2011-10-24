<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.edit" args="[message(code: 'facility')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'facility')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: facility]"/>

    <g:form id="${facility.id}">
      <div>
        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:textField class="countable${facility.profile.constraints.fullName.maxSize} ${hasErrors(bean: facility, field: 'profile.fullName', 'errors')}" size="41" maxlength="80" name="fullName" value="${fieldValue(bean: facility, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="4" valign="top" class="name"><g:message code="description"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" toolbar="Basic">
                ${fieldValue(bean:facility,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

          <tr class="prop">
            <td valign="middle" class="name"><g:message code="groupColony"/>:</td>
            <td colspan="3" valign="middle" class="name"><g:message code="phone"/>:</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <g:select from="${allColonias}" class="drop-down-240" name="colonia" optionKey="id" optionValue="profile" value="${colony?.id}"/>
            </td>
            <td colspan="3" valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.phone', 'errors')}" size="30" name="phone" value="${fieldValue(bean: facility, field: 'profile.phone').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td height="25" valign="top" class="name"><g:message code="street"/></td>
            <td valign="top" class="name"><g:message code="zip"/></td>
            <td valign="top" class="name"><g:message code="city"/></td>
            <td valign="top" class="name"><g:message code="country"/></td>
          </tr>

          <tr class="prop">
            <td width="290" valign="top" class="value">
              <g:textField class="countable${facility.profile.constraints.street.maxSize} ${hasErrors(bean: facility, field: 'profile.street', 'errors')}" size="41" name="street" value="${fieldValue(bean: facility, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="101" valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.zip', 'errors')}" size="12" name="zip" value="${fieldValue(bean: facility, field: 'profile.zip').decodeHTML()}"/>
            </td>
            <td width="220" valign="top" class="value">
              <g:textField class="countable${facility.profile.constraints.city.maxSize} ${hasErrors(bean: facility, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: facility, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.country', 'errors')}" size="30" name="country" value="${fieldValue(bean: facility, field: 'profile.country').decodeHTML()}"/>
            </td>
          </tr>

        </table>

      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
