<!DOCTYPE html>

<html>
  <head>
	<title>${grailsApplication.config.application.name} - <g:message code="error"/> 500</title>
     <link rel="stylesheet" href="${resource (dir:'css', file:'error.css')}" type="text/css">
  </head>
  <body>
    <div id="container">
        <img src="${resource(dir: 'images/icons', file: 'icon_alert.png')}" alt="${message(code: 'error')}"/>
        <h1>We are sorry but something went wrong!</h1>
        <p>A mail has been sent to the developers which will try to fix the problem immediately.</p>
        <p><b>Timestamp:</b> <g:formatDate date="${new Date()}" format="dd.MM.yyyy - HH:mm"/> (UTC)</p></p>
    </div>
  </body>
</html>