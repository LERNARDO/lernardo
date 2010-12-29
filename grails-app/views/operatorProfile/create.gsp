<head>
  <meta name="layout" content="private"/>
  <title><g:message code="operator.profile.create"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="operator.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: operator]"/>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="operator.profile.name"/></td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: operator, field: 'profile.fullName', 'errors')}" size="103" maxlength="80" name="fullName" value="${fieldValue(bean: operator, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="operator.profile.email"/></td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: operator, field: 'user.email', 'errors')}" size="103" type="text" maxlength="80" name="email" value="${fieldValue(bean: operator, field: 'user.email').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="operator.profile.zip"/></td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: operator, field: 'profile.zip', 'errors')}" size="103" name="zip" value="${fieldValue(bean: operator, field: 'profile.zip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="operator.profile.city"/></td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: operator, field: 'profile.city', 'errors')}" size="103" name="city" value="${fieldValue(bean: operator, field: 'profile.city').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="operator.profile.street"/></td>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: operator, field: 'profile.street', 'errors')}" size="103" name="street" value="${fieldValue(bean: operator, field: 'profile.street').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="operator.profile.description"/></td>
            <td valign="top" class="value">
              <g:textArea class="countable2000 ${hasErrors(bean: operator, field: 'profile.description', 'errors')}" rows="6" cols="100" name="description" value="${fieldValue(bean: operator, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="operator.profile.phone"/></td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: operator, field: 'profile.phone', 'errors')}" size="103" name="phone" value="${fieldValue(bean: operator, field: 'profile.phone').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="languageSelection"/></td>
            <td valign="top" class="value">
              <erp:localeSelect class="drop-down-280" name="locale" value="${operator?.user?.locale}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="showTips"/></td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${operator?.profile?.showTips}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="active"/></td>
            <td valign="top" class="value">
              <g:checkBox name="enabled" value="${operator?.user?.enabled}"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
