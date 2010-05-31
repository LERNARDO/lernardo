<head>
  <meta name="layout" content="private"/>
  <title>Einrichtung anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Einrichtung anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <g:hasErrors bean="${facility}">
      <div class="errors">
        <g:renderErrors bean="${facility}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tr class="prop">
            <td width="290" height="25" valign="top" class="name">
              <label for="fullName">
                <g:message code="facility.profile.name"/>
              </label>
            </td>
            <td colspan="3" valign="top" class="name">
              <label for="description">
                <g:message code="facility.profile.description"/>
              </label>
            </td>
          </tr>
          <tr>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.fullName', 'errors')}" size="41" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: facility, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td colspan="3" valign="top" class="value">
              <g:textArea class="${hasErrors(bean: facility, field: 'profile.description', 'errors')}" rows="1" cols="81" id="description" name="description" value="${fieldValue(bean: facility, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td height="25" valign="top" class="name">
              <label for="street">
                <g:message code="facility.profile.street"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="zip">
                <g:message code="facility.profile.zip"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="city">
                <g:message code="facility.profile.city"/>
              </label>
            <td valign="top" class="name">
              <label for="country">
                <g:message code="facility.profile.country"/>
              </label>
            </td>
          </tr>

          <tr class="prop">
            <td width="290" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.street', 'errors')}" size="41" id="street" name="street" value="${fieldValue(bean: facility, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="101" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.zip', 'errors')}" size="12" id="zip" name="zip" value="${fieldValue(bean: facility, field: 'profile.zip').decodeHTML()}"/>
            </td>
            <td width="220" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: facility, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td valign="middle" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.country', 'errors')}" size="30" id="country" name="country" value="${fieldValue(bean: facility, field: 'profile.country').decodeHTML()}"/>
            </td>
          </tr>
        </table>
        <div class="email">
          <table>
            <tr class="prop">
              <app:isAdmin>
                <td width="60" valign="middle" class="name">
                  <label for="enabled">
                    <g:message code="active"/>
                  </label>
                </td>
                <td width="40" valign="middle" class="value">
                  <g:checkBox name="enabled" value="${facility?.user?.enabled}"/>
                </td>
              </app:isAdmin>
              <td width="70" valign="middle" class="name">
                <label for="email">
                  <g:message code="facility.profile.email"/>
                </label>
              </td>
              <td width="320" valign="middle" class="value">
                <g:textField class="${hasErrors(bean: facility, field: 'user.email', 'errors')}" size="47" maxlength="80" id="email" name="email" value="${fieldValue(bean: facility, field: 'user.email')}"/>
              </td>
              <td width="130" valign="middle" class="name">
                <label for="locale">
                  <g:message code="languageSelection"/>
                </label>
              </td>
              <td valign="middle" class="value">
                <app:localeSelect class="drop-down-150" name="locale" value="${facility?.user?.locale}"/>
              </td>
            </tr>
          </table>
        </div> <!--div email close -->
      </div>  <!-- div dialog close -->
      <div class="green">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
