© 2012 Future Wings (Version: <g:meta name="app.version"/><erp:ifGrailsEnv env="['development', 'test']">
  , Environment: ${g.meta(name:'build.env') ?: "Development"}, Build: ${g.meta(name:'build.buildnum') ?: "Local"}</erp:ifGrailsEnv>)
  <g:link controller="public" action='imprint'><g:message code="footer.imprint"/></g:link><g:link controller="public" action='terms'><g:message code="footer.terms"/></g:link><g:link controller="public" action='privacy'><g:message code="footer.privacy"/></g:link>
<p>Built with Grails <g:meta name="app.grails.version"/></p>

