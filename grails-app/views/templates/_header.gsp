<div style="clear: both;"></div>
<a href="${g.resource(dir:'')}"><div id="logo"></div></a>
<div id="info">
  <app:isLoggedIn>
    Angemeldet als <span class="bold">${currentEntity.profile.fullName}</span>
    <g:link controller="security" action='logout'> [Abmelden]</g:link><br/>
    %{-- TODO: this is for testing purposes only, remove later --}%
    <a href="?lang=de">Deutsch</a> | <a href="?lang=es">Español</a>
  </app:isLoggedIn>
  <app:isNotLoggedIn>
    <a href="?lang=de">Deutsch</a> | <a href="?lang=es">Español</a>
  </app:isNotLoggedIn>
  %{-- TODO: find out why activeSessions is NULL on DEV and TEST instance --}%
  %{--Aktive User: ${ApplicationService.activeSessions}--}%
</div>
