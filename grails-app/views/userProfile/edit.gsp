<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | User bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>User bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${user}">
      <div class="errors">
        <g:renderErrors bean="${user}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${user.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="user.profile.firstName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class=" ${hasErrors(bean:user,field:'profile.firstName','errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean:user,field:'profile.firstName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="user.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean:user,field:'profile.lastName','errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean:user,field:'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="user.profile.email"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: user, field: 'user.email', 'errors')}" size="30" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: user, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lang">
                <g:message code="languageSelection"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="lang" from="${[1:'Deutsch', 2:'Spanisch']}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="showTips">
                <g:message code="showTips"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${user.profile.showTips}"/>
            </td>
          </tr>

          <app:isAdmin>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="enabled">
                  <g:message code="active"/>
                </label>
              </td>
              <td valign="top" class="value">
                <g:checkBox name="enabled" value="${user.user.enabled}"/>
              </td>
            </tr>
          </app:isAdmin>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="password"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:link controller="profile" action="changePassword" id="${user.id}">Passwort ändern</g:link>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="show" id="${user.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
