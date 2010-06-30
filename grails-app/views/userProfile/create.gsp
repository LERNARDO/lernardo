<head>
  <meta name="layout" content="private"/>
  <title><g:message code="user.profile.create"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="user.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <g:hasErrors bean="${user}">
      <div class="errors">
        <g:renderErrors bean="${user}" as="list"/>
      </div>
    </g:hasErrors>
    <g:form action="save" method="post">
      <div class="dialog">
      
      <table>
          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="user.profile.firstName"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="user.profile.lastName"/>
              </label>
            </td>

          </tr>
        <tr class="prop">
            <td width="440" valign="top" class="value">
              <g:textField class=" ${hasErrors(bean:user,field:'profile.firstName','errors')}" size="60" id="firstName" name="firstName" value="${fieldValue(bean:user,field:'profile.firstName').decodeHTML()}"/>
            </td>

            <td width="440" valign="top" class="value">
              <g:textField class="${hasErrors(bean:user,field:'profile.lastName','errors')}" size="60" id="lastName" name="lastName" value="${fieldValue(bean:user,field:'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>
      </table>
       </div>
        <div class="email">
            <table>
              <tr>
                <td width="90" valign="middle">
                  <label for="enabled">
                    <g:message code="active"/>
                  </label>
                  <g:checkBox name="enabled" value="${user?.user?.enabled}"/>
                </td>
                <td width="350" valign="middle">
                  <label for="email">
                    <g:message code="user.profile.email"/>
                  </label>:
                <g:textField class="${hasErrors(bean: user, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: user, field: 'user.email')}"/>
                </td>
                <td>
                  <label for="locale">
                    <g:message code="languageSelection"/>
                  </label>:
                <app:localeSelect class="drop-down-200" name="locale" value="${user?.user?.locale}"/>
                </td>
              </tr>
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