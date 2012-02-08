<!DOCTYPE html>

<html>
  <head>
	<title>${grailsApplication.config.application.name} - <g:message code="error"/> 500</title>
     <link rel="stylesheet" href="${resource (dir:'css', file:'error.css')}" type="text/css">
  </head>
  <body>
    <div id="container">
        <img src="${resource(dir: 'images/icons', file: 'icon_alert.png')}" alt="${message(code: 'error')}"/>
        <p style="text-align: left;"><g:message code="error500_1"/></p>
        <p style="text-align: left;"><g:message code="error500_2"/></p>
        <ul style="text-align: left;">
          <li><g:message code="error500_3"/></li>
          <li><g:message code="error500_4"/></li>
          <li><g:message code="error500_5"/></li>
        </ul>
        <p style="text-align: left;"><g:message code="error500_6"/></p>
    </div>
  </body>
</html>