<div style="clear: both;"></div>
<a href="${g.resource(dir:'')}"><div id="logo"></div></a>
<div id="info">
  <g:isLoggedIn>
    Angemeldet als <span class="bold">${currentEntity.profile.fullName}</span>
    <g:link controller="logout" action='index'> [Abmelden]</g:link><br/>
  </g:isLoggedIn>
  <g:isNotLoggedIn>
    <a href="?lang=de">Deutsch</a> | <a href="?lang=es">Español</a>
  </g:isNotLoggedIn>
  %{-- TODO: find out why activeSessions is NULL on DEV and TEST instance --}%
  %{--Aktive User: ${ApplicationService.activeSessions}--}%
</div>