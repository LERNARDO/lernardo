<%@ page contentType="text/html" %>
<html>
<body>
<p><span class="strong"><g:message code="hello.User" args="[entity.profile]"/></span></p>
<br/>
<p>
  <g:message code="password.reset" args="[grailsApplication.config.customerName, grailsApplication.config.application.name]"/><br/>
  ${password}
</p>
<p><g:message code="your.team" args="[grailsApplication.config.application.name]"/></p>
<br/>
<p><g:message code="doNotAnswer"/></p>
</body>
</html>