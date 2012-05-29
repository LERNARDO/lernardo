© 2012 Future Wings (Version: <g:meta name="app.version"/><ub:ifGrailsEnv env="['development', 'test']">
  , Environment: ${g.meta(name:'deploy.env') ?: "Development"}, Build: ${g.meta(name:'deploy.buildnum') ?: "Local"}%{--(${g.meta(name:'deploy.vcsver') ?: "n/a"})--}%</ub:ifGrailsEnv>)
  <g:link controller="public" action='imprint'><g:message code="footer.imprint"/></g:link><g:link controller="public" action='terms'><g:message code="footer.terms"/></g:link><g:link controller="public" action='privacy'><g:message code="footer.privacy"/></g:link>

