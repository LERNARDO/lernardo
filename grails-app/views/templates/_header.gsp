<div style="clear: both;"></div>
<a href="${g.resource(dir:'')}"><div id="logo"></div></a>
<div id="info">
  <g:isLoggedIn>
    Angemeldet als <ub:entityName format="full"/>
    <g:link controller="logout" action='index'> [Abmelden]</g:link><br/>
  </g:isLoggedIn>
  %{-- TODO: find out why activeSessions is NULL on DEV and TEST instance --}%
  %{--Aktive User: ${ApplicationService.activeSessions}--}%
</div>