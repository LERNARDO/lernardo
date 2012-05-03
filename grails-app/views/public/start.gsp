<head>
  <meta name="layout" content="public"/>
  <title>Login</title>
</head>

<body>
  <erp:isLoggedIn>
    <p><g:message code="alreadyLoggedIn"/></p>
    <p><g:link controller="event" action="index"><g:message code="continue"/></g:link></p>
  </erp:isLoggedIn>
  <erp:isNotLoggedIn>
    <g:form controller="app" action="do_login">
      <table>
        <tr>
          <td>
            <span style="line-height: 25px; font-weight: bold;">E-Mail</span><br/>
            <g:textField name="userid" size="40" tabindex="1"/></td>
        </tr>
        <tr>
          <td style="padding-top: 10px;">
            <span style="line-height: 25px; font-weight: bold;"><g:message code="password"/></span><br/>
            <g:passwordField name="password" size="40" tabindex="2"/></td>
        </tr>
        <tr>
          <td colspan="2">
            <span style="line-height: 35px;"><g:link controller="app" action="password"><g:message code="pass.forgotten"/></g:link></span>
          </td>
        </tr>
        <tr>
          <td colspan="2" style="height: 25px"><g:checkBox name="remember_me"/> <g:message code="stayLoggedIn"/></td>
        </tr>
      </table>

      <div class="buttons">
        <div style="margin-top: 10px;"><g:submitButton class="buttonGreen" name="submitButton" value="Login"/></div>
      </div>
    </g:form>
  </erp:isNotLoggedIn>

</body>