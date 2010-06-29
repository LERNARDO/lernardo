<div style="clear: both;"></div>
<a href="${g.resource(dir:'')}"><div id="logo"></div></a>
<div id="info">
  <g:isLoggedIn>
    <g:message code="header.logedonAs"/> <span class="bold">${currentEntity.profile.fullName}</span>
    <g:link controller="logout" action='index'> [<g:message code="header.logoff"/>]</g:link><br/>
    %{-- TODO: this is for testing purposes only, remove later --}%
    <a href="?lang=de">Deutsch</a> | <a href="?lang=es">Español</a>
  </g:isLoggedIn>
  <g:isNotLoggedIn>
    <a href="?lang=de">Deutsch</a> | <a href="?lang=es">Español</a>
  </g:isNotLoggedIn>
  %{-- TODO: find out why activeSessions is NULL on DEV and TEST instance --}%
  %{--Aktive User: ${ApplicationService.activeSessions}--}%
</div>