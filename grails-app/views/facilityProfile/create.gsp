<head>
  <meta name="layout" content="private"/>
  <title><g:message code="facility.profile.create"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="facility.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: facility]"/>

    <g:form>
      <div>
        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="facility.profile.name"/></td>
            %{--<td colspan="3" valign="top" class="name"><g:message code="facility.profile.description"/></td>--}%
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: facility, field: 'profile.fullName', 'errors')}" size="41" maxlength="80" name="fullName" value="${fieldValue(bean: facility, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            %{--<td colspan="3" valign="top" class="value">
              <g:textArea class="countable2000 ${hasErrors(bean: facility, field: 'profile.description', 'errors')}" rows="1" cols="81" name="description" value="${fieldValue(bean: facility, field: 'profile.description').decodeHTML()}"/>
            </td>--}%
          </tr>

          <tr class="prop">
            <td colspan="4" valign="top" class="name"><g:message code="facility.profile.description"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" toolbar="Basic">
                ${fieldValue(bean:facility,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="4" valign="middle" class="name"><g:message code="facility.profile.colony"/>:</td>
          </tr>

          <tr class="prop">
            <td colspan="4" valign="top" class="value">
              <g:select from="${allColonias}" class="drop-down-240" name="colonia" optionKey="id" optionValue="profile"/>
            </td>
          </tr>

          <tr class="prop">
            <td height="25" valign="top" class="name"><g:message code="facility.profile.street"/></td>
            <td valign="top" class="name"><g:message code="facility.profile.zip"/></td>
            <td valign="top" class="name"><g:message code="facility.profile.city"/></td>
            <td valign="top" class="name"><g:message code="facility.profile.country"/></td>
          </tr>

          <tr class="prop">
            <td width="290" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: facility, field: 'profile.street', 'errors')}" size="41" name="street" value="${fieldValue(bean: facility, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="101" valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.zip', 'errors')}" size="12" name="zip" value="${fieldValue(bean: facility, field: 'profile.zip').decodeHTML()}"/>
            </td>
            <td width="220" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: facility, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: facility, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.country', 'errors')}" size="30" name="country" value="${fieldValue(bean: facility, field: 'profile.country').decodeHTML()}"/>
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
