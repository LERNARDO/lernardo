<%@ page contentType="text/html" %>
<html>
<body>
%{--
<p><span class="strong">Hallo ${entity.profile.fullName}!</span></p>
--}%
<p><span class="strong"><g:message code="hello.User" args="[entity.profile.fullName]"/></span></p>
<br/>
<p>
  %{--
  Dein Passwort für das ${grailsApplication.config.projectName} ERP wurde zurückgesetzt auf:<br/>
  --}%
  <g:message code="password.reset" args="[grailsApplication.config.projectName]"/><br/>
  ${password}
</p>
%{--
<p>Dein ${grailsApplication.config.projectName} Team!</p>
--}%
<p><g:message code="your.team" args="[grailsApplication.config.projectName]"/></p>
<br/>
%{--
<p>Dies ist eine automatisch erstellte E-Mail, bitte nicht darauf antworten!</p>
--}%
<p><g:message code="doNotAnswer"/></p>
</body>
</html>