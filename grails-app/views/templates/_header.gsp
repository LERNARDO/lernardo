<div style="clear: both;"></div>
<a href="${g.resource(dir:'')}"><div id="logo"></div></a>
<div id="info">
  <app:isLoggedIn>
    <g:message code="header.logedonAs"/> <span class="bold">${currentEntity.profile.fullName}</span>
    <g:link controller="security" action='logout'> [<g:message code="header.logoff"/>]</g:link><br/>
    %{-- TODO: this is for testing purposes only, remove later --}%
    <a href="?lang=de">Deutsch</a> | <a href="?lang=es">Español</a>
  </app:isLoggedIn>
  <app:isNotLoggedIn>
    <a href="?lang=de">Deutsch</a> | <a href="?lang=es">Español</a>
  </app:isNotLoggedIn>
  %{-- TODO: find out why activeSessions is NULL on DEV and TEST instance --}%
  %{--Aktive User: ${ApplicationService.activeSessions}--}%
</div>
