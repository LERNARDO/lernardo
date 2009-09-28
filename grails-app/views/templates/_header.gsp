  <div style="clear: both;"></div>
  <a href="${g.resource(dir:'')}"><div id="logo"></div></a>
  <div id="info">
    <g:isLoggedIn>
      %{--<span>logged in as <span><g:loggedInUserInfo field="email"/></span>--}%
        Angemeldet als <ub:entityName format="full"/>
        <g:link controller="logout" action='index'> [Abmelden] </g:link>
    </g:isLoggedIn>
  </div>