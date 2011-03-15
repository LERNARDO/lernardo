<div style="clear: both;"></div>
<a href="${g.resource(dir:'')}"><div id="logo"></div></a>
<div id="info">
  <erp:isLoggedIn>
    <a href="?lang=de"><img src="${g.resource(dir:'images/icons', file:'flag_at.png')}" alt="Austria"/></a> <a href="?lang=es"><img src="${g.resource(dir:'images/icons', file:'flag_mx.png')}" alt="Mexico"/></a>
    <g:message code="header.loggedInAs"/> <span class="bold">${currentEntity?.profile?.fullName}</span>
    <g:link controller="security" action='logout'><img src="${g.resource(dir:'images/icons', file:'icon_logout.png')}" alt="Achtung" align="top"/>%{-- [<g:message code="header.logOut"/>]--}%</g:link><br/>
  </erp:isLoggedIn>
</div>
