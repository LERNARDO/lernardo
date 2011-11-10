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

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: facility, field: 'profile.fullName', 'errors')}" size="41" maxlength="80" name="fullName" value="${fieldValue(bean: facility, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="description" height="200px" toolbar="Basic">
              ${fieldValue(bean:facility,field:'profile.description').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="groupColony"/></td>
          <td valign="top" class="value">
            <g:select from="${allColonias}" name="colonia" optionKey="id" optionValue="profile"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="phone"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: facility, field: 'profile.phone', 'errors')}" size="30" name="phone" value="${fieldValue(bean: facility, field: 'profile.phone').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="street"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: facility, field: 'profile.street', 'errors')}" size="40" name="street" value="${fieldValue(bean: facility, field: 'profile.street').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="zip"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: facility, field: 'profile.zip', 'errors')}" size="10" name="zip" value="${fieldValue(bean: facility, field: 'profile.zip').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="city"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: facility, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: facility, field: 'profile.city').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="country"/></td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: facility, field: 'profile.country', 'errors')}" size="30" name="country" value="${fieldValue(bean: facility, field: 'profile.country').decodeHTML()}"/>
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
