<%@ page contentType="text/html" %>
<html>
<body>
<p><span class="strong">Hallo ${entity.profile.fullName}!</span></p>
<br/>
<p>
  Dein Passwort für das ${grailsApplication.config.projectName} ERP wurde zurückgesetzt auf:<br/>
  ${password}
</p>
<p>Dein ${grailsApplication.config.projectName} Team!</p>
<br/>
<p>Dies ist eine automatisch erstellte E-Mail, bitte nicht darauf antworten!</p>
</body>
</html>