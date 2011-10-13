<head>
  <meta name="layout" content="public2"/>
  <title>Login</title>
</head>

<body>
<table class="start">
  <tr>
    <td class="logo">erpel</td>
  </tr>
  <tr>
    <td>
      <div class="loginbox">
      <g:if test="${flash.message}">
        <div id="flash-msg">
          ${flash.message}
        </div>
      </g:if>
      <div class="flags"><a href="?lang=de"><img src="${g.resource(dir:'images/icons', file:'flag_at.png')}" alt="German"/></a> <a href="?lang=es"><img src="${g.resource(dir:'images/icons', file:'flag_mx.png')}" alt="Spanish"/> <a href="?lang=en"><img src="${g.resource(dir:'images/icons', file:'flag_gb.png')}" alt="English"/></a></div>
      <g:form controller="security" action="do_login">
        <table>
          <tr>
            <td style="color: #444;">
              <span style="line-height: 25px; font-weight: bold;">E-Mail</span><br/>
              <g:textField name="userid" size="40" tabindex="1"/></td>
          </tr>
          <tr>
            <td style="color: #444;">
              <span style="line-height: 25px; font-weight: bold;">Passwort</span><br/>
              <g:passwordField name="password" size="40" tabindex="2"/></td>
          </tr>
          <tr>
            <td colspan="2"><g:link controller="app" action="password">Passwort vergessen?</g:link></td>
          </tr>
          <tr>
            <td colspan="2" style="height: 25px"><g:checkBox name="remember_me"/> Angemeldet bleiben</td>
          </tr>
        </table>


        <div class="buttons">
          <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="Login"/></div>
        </div>
      </g:form>
      </div>
    </td>
  </tr>
  <tr>
    <td class="footer">
      <g:link controller="static" action='imprint'><g:message code="footer.imprint"/></g:link> | <g:link controller="static" action='terms'><g:message code="footer.terms"/></g:link><g:link controller="static" action='privacy'> | <g:message code="footer.privacy"/></g:link><br/>

      © 2011 Future Wings (Version: <g:meta name="app.version"/><ub:ifGrailsEnv env="['development', 'test']">
        , Environment: ${g.meta(name:'deploy.env') ?: "Development"}, Build: ${g.meta(name:'deploy.buildnum') ?: "Local"}%{--(${g.meta(name:'deploy.vcsver') ?: "n/a"})--}%</ub:ifGrailsEnv>)
        </td>
  </tr>
</table>

</body>