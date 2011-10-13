<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8"/>
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'reset-fonts-grids.css')}" type="text/css">
  <g:set var="customer" value="${grailsApplication.config.customer}"/>
  <less:stylesheet name="public"/>
  <less:stylesheet name="${customer}"/>
  <less:scripts/>
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <ga:trackPageview/>
</head>

<body>

  <g:layoutBody/>

</body>
</html>
