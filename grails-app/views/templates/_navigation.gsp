<ul class="navigation" id="navigation_topmain">
  <li class="navigation_first"><g:link url="${g.resource(dir:'/')}">Home</g:link></li>
  <g:isLoggedIn>
    <li><g:link controller="app" action='start'>ERP</g:link></li>
  </g:isLoggedIn>
  <g:isNotLoggedIn>
    <li><g:link controller="static" action='erpinfo'>ERP</g:link></li>
  </g:isNotLoggedIn>
  <li><g:link controller="static" action='einrichtungen'>Einrichtungen</g:link></li>
  <li class="navigation_last"><g:link controller="static" action='kontakt'>Kontakt</g:link></li>
  %{--<li class="navigation_last"><g:link controller="static" action='registration'>Registrieren</g:link></li>--}%
</ul>