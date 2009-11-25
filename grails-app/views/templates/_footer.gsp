Future Wings © 2009 - <g:link controller="static" action='nutzung'>Nutzungsbedingungen</g:link> - <g:link controller="static" action='datenschutz'>Datenschutzrichtlinien</g:link>
<br/>
v<g:meta name="app.version"/> -
<ub:ifGrailsEnv env="['development', 'test']">
  ${g.meta(name:'deploy.env') ?: "development"} Build ${g.meta(name:'deploy.buildnum') ?: "local"} (${g.meta(name:'deploy.vcsver') ?: "n/a"})</p>
</ub:ifGrailsEnv>