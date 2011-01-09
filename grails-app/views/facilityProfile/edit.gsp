<head>
  <meta name="layout" content="private"/>
  <title><g:message code="facility.profile.edit"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="facility.profile.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: facility]"/>

    <g:form action="update" id="${facility.id}">
      <div class="dialog">
        <table>

          <tr class="prop">
            <td width="290" height="25" valign="top" class="name"><g:message code="facility.profile.name"/></td>
            <td colspan="3" valign="top" class="name"><g:message code="facility.profile.description"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:textField class="countable${facility.profile.constraints.fullName.maxSize} ${hasErrors(bean: facility, field: 'profile.fullName', 'errors')}" size="41" maxlength="80" name="fullName" value="${fieldValue(bean: facility, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td colspan="3" valign="top" class="value">
              <g:textArea class="countable${facility.profile.constraints.description.maxSize} ${hasErrors(bean: facility, field: 'profile.description', 'errors')}" rows="1" cols="81" name="description" value="${fieldValue(bean: facility, field: 'profile.description').decodeHTML()}"/>
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
        <div class="email">
          <table>
            <tr class="prop">
              %{--<erp:isOperator entity="${currentEntity}">
                <td width="90" valign="top" class="name"><g:message code="active"/></td>
                <td width="30" valign="top" class="value">
                  <g:checkBox name="enabled" value="${facility?.user?.enabled}"/>
                </td>
              </erp:isOperator>--}%
              <td width="70" valign="top" class="name"><g:message code="facility.profile.email"/></td>
              <td width="320" valign="top" class="value">
                <g:textField class="${hasErrors(bean: facility, field: 'user.email', 'errors')}" size="47" maxlength="80" name="email" value="${fieldValue(bean: facility, field: 'user.email')}"/>
              </td>
              %{--<td width="130" valign="top" class="name"><g:message code="languageSelection"/></td>
              <td valign="top" class="value">
                <erp:localeSelect class="drop-down-150" name="locale" value="${facility?.user?.locale}"/>
              </td>--}%
            </tr>
            %{--<tr>
              <td valign="top" class="name"><g:message code="showTips"/></td>
              <td valign="top" class="value">
                <g:checkBox name="showTips" value="${facility.profile.showTips}"/>
              </td>
              <td valign="top" class="name"><g:message code="password"/></td>
              <td valign="top" class="value">
                <g:link controller="profile" action="changePassword" id="${facility.id}"><g:message code="change"/></g:link>
              </td>
            </tr>--}%
          </table>
        </div>

      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <erp:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${facility.id}" onclick="${erp.getLinks(id: facility.id)}"><g:message code="delete"/></g:link>
        </erp:isOperator>
        <g:link class="buttonGray" action="show" id="${facility.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
