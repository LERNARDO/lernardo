<%@ page contentType="text/html" %>
<html>
<body>
<p><span class="strong"><g:message code="hello.User" args="[entity.profile.fullName]"/></span></p>
<br/>
<p>
  <g:message code="password.reset" args="[grailsApplication.config.projectName]"/><br/>
  ${password}
</p>
<p><g:message code="your.team" args="[grailsApplication.config.projectName]"/></p>
<br/>
<p><g:message code="doNotAnswer"/></p>
</body>
</html>