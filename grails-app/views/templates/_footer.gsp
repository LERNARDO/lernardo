© 2012 Future Wings (Version: <g:meta name="app.version"/><erp:ifGrailsEnv env="['development', 'test']">
  , Environment: ${g.meta(name:'deploy.env') ?: "Development"}, Build: ${g.meta(name:'deploy.buildnum') ?: "Local"}%{--(${g.meta(name:'deploy.vcsver') ?: "n/a"})--}%</erp:ifGrailsEnv>)
  <g:link controller="public" action='imprint'><g:message code="footer.imprint"/></g:link><g:link controller="public" action='terms'><g:message code="footer.terms"/></g:link><g:link controller="public" action='privacy'><g:message code="footer.privacy"/></g:link>
<p>Powered by Grails <g:meta name="app.grails.version"/></p>

