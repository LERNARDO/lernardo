<div id="nav">
  <ul class="navigation" id="navigation_topmain">
    <li class="navigation_first"><g:link url="${g.resource(dir:'/')}"><g:message code="nav.news"/></g:link></li>
    <erp:isLoggedIn>
      <li><g:link controller="app" action='start'><g:message code="nav.start"/></g:link></li>
    </erp:isLoggedIn>
    <erp:isNotLoggedIn>
      <li><g:link controller="static" action='erpinfo'><g:message code="nav.erpinfo"/></g:link></li>
    </erp:isNotLoggedIn>
    %{--<li><g:link controller="static" action='einrichtungen'>Einrichtungen</g:link></li>
    <li class="navigation_last"><g:link controller="static" action='kontakt'>Kontakt</g:link></li>--}%
    %{--<li class="navigation_last"><g:link controller="static" action='registration'>Registrieren</g:link></li>--}%
  </ul>
</div>
