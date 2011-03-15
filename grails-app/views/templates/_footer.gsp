© Future Wings, 2010 - 2011 (Version: <g:meta name="app.version"/><ub:ifGrailsEnv env="['development', 'test']">
  , Environment: ${g.meta(name:'deploy.env') ?: "Development"}, Build: ${g.meta(name:'deploy.buildnum') ?: "Local"}%{--(${g.meta(name:'deploy.vcsver') ?: "n/a"})--}%</ub:ifGrailsEnv>)
  <g:link controller="static" action='nutzung'><g:message code="footer.usage"/></g:link><g:link controller="static" action='datenschutz'><g:message code="footer.privacy"/></g:link>

