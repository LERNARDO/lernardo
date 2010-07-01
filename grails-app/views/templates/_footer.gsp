Future Wings © 2010 - <g:link controller="static" action='nutzung'><g:message code="footer.usage"/></g:link> - <g:link controller="static" action='datenschutz'><g:message code="footer.privacy"/></g:link>
<br/>
v<g:meta name="app.version"/>
<ub:ifGrailsEnv env="['development', 'test']">
  - ${g.meta(name:'deploy.env') ?: "development"} Build ${g.meta(name:'deploy.buildnum') ?: "local"} (${g.meta(name:'deploy.vcsver') ?: "n/a"})</p>
</ub:ifGrailsEnv>