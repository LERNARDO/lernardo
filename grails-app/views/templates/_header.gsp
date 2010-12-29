<div style="clear: both;"></div>
<a href="${g.resource(dir:'')}"><div id="logo"></div></a>
<div id="info">
  <erp:isLoggedIn>
    <g:message code="header.loggedInAs"/> <span class="bold">${currentEntity?.profile?.fullName}</span>
    <g:link controller="security" action='logout'> [<g:message code="header.logOut"/>]</g:link><br/>
  </erp:isLoggedIn>
  <a href="?lang=de">Deutsch</a> | <a href="?lang=es">Español</a>
</div>
