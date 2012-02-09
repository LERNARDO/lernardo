<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8"/>
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssfonts/fonts.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssgrids/grids-min.css" type="text/css">
  <g:set var="customer" value="${grailsApplication.config.customer}"/>
  <less:stylesheet name="public"/>
  <less:scripts/>
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <ga:trackPageview/>
</head>

<body>
<table class="start">
  <tr>
    <td class="logo">
      <div class="title">
        <erp:isNotLoggedIn>
          <a href="${g.resource(dir:'')}">${grailsApplication.config.application.name}</a>
        </erp:isNotLoggedIn>
        <erp:isLoggedIn>
          <g:link controller="event" action="index">${grailsApplication.config.application.name}</g:link>
        </erp:isLoggedIn>
      </div>
      <div class="subtitle">
        ${grailsApplication.config.customerName}
      </div>
    </td>
  </tr>
  <tr>
    <td>
      <div class="flags">
        <span class="flag"><a href="?lang=de"><img src="${g.resource(dir:'images/icons', file:'flag_at.png')}" alt="German"/></a></span>
        <span class="flag"><a href="?lang=es"><img src="${g.resource(dir:'images/icons', file:'flag_mx.png')}" alt="Spanish"/></a></span>
        <span class="flag"><a href="?lang=en"><img src="${g.resource(dir:'images/icons', file:'flag_gb.png')}" alt="English"/></a></span>
      </div>
    </td>
  </tr>
  <tr>
    <td>
      <div class="mainbox">
        <g:if test="${flash.message}">
          <div id="error-msg">
            ${flash.message}
          </div>
        </g:if>
        <g:layoutBody/>
      </div>
    </td>
  </tr>
  <tr>
    <td class="footer">
      <span class="footerlink"><g:link controller="static" action='imprint'><g:message code="footer.imprint"/></g:link></span>|<span class="footerlink"><g:link controller="static" action='terms'><g:message code="footer.terms"/></g:link></span>|<span class="footerlink"><g:link controller="static" action='privacy'><g:message code="footer.privacy"/></g:link></span><br/>
      © 2011 Future Wings (Version: <g:meta name="app.version"/><ub:ifGrailsEnv env="['development', 'test']">, Environment: ${g.meta(name:'deploy.env') ?: "Development"}, Build: ${g.meta(name:'deploy.buildnum') ?: "Local"}</ub:ifGrailsEnv>)
        </td>
  </tr>
</table>

</body>


</body>
</html>
