<head>
  <meta name="layout" content="private"/>
  <title>User bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1 style="float: left">User bearbeiten</h1>
    <div class="icons" style="text-align: right;">
      <g:link action="show" id="${user.id}"><img src="${resource (dir:'images/icons', file:'icon_cancel.png')}" alt="${message(code:'cancel')}" align="top"/></g:link>
    </div>
  </div>
</div>
<div class="boxGray" style="clear: both;">
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

          </tbody>
        </table>
      </div>
       <div class="email">
		<table>
		<tr>
			<app:isAdmin>
			<td width="85"  valign="middle">
                <label for="enabled">
                  <g:message code="active"/>
                </label>
                <app:isAdmin>
                  <g:checkBox name="enabled" value="${user?.user?.enabled}"/>
                </app:isAdmin>
                <app:notAdmin>
                  <g:checkBox name="enabled" value="${user?.user?.enabled}" disabled="true"/>
                </app:notAdmin>
              </td>
          </app:isAdmin>
            <td width="150" valign="middle">
              <label>
                <g:message code="password"/>:
              </label>
              <g:link controller="profile" action="changePassword" id="${user.id}">Ändern</g:link>
            </td>

			<td width="270"  valign="middle">
			<label for="email">
				<g:message code="user.profile.email"/>
            </label>:
            <g:textField class="${hasErrors(bean: user, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: user, field: 'user.email')}"/>
            </td>
			<td valign="middle">
			    <label for="locale">
                <g:message code="languageSelection"/>
				</label>:
				<app:localeSelect class="drop-down-150" name="locale" value="${user?.user?.locale}"/>
				</td>
		</tr>
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
