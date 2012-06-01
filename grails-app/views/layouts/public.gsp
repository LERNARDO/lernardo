<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8"/>
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <r:require modules="common"/>
  <r:layoutResources/>
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
        <span class="footerlink"><g:link controller="public" action='imprint'><g:message code="footer.imprint"/></g:link></span>|<span class="footerlink"><g:link controller="public" action='terms'><g:message code="footer.terms"/></g:link></span>|<span class="footerlink"><g:link controller="public" action='privacy'><g:message code="footer.privacy"/></g:link></span><br/>
        © 2011 Future Wings (Version: <g:meta name="app.version"/><erp:ifGrailsEnv env="['development', 'test']">, Environment: ${g.meta(name:'deploy.env') ?: "Development"}, Build: ${g.meta(name:'deploy.buildnum') ?: "Local"}</erp:ifGrailsEnv>)
          </td>
    </tr>
  </table>

  <r:layoutResources/>
</body>

</html>
