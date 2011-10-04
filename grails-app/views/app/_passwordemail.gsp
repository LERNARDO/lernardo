<%@ page contentType="text/html" %>
<html>
<body>
<p><span class="strong"><g:message code="hello.User" args="[entity.profile.fullName]"/></span></p>
<br/>
<p>
  <g:message code="password.reset" args="[grailsApplication.config.projectName, grailsApplication.config.application.name]"/><br/>
  ${password}
</p>
<p><g:message code="your.team" args="[grailsApplication.config.application.name]"/></p>
<br/>
<p><g:message code="doNotAnswer"/></p>
</body>
</html>