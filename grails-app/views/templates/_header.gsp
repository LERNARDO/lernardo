<div style="clear: both;"></div>
<a href="${g.resource(dir:'')}"><div id="logo"></div></a>
<div id="info">
  <erp:isLoggedIn>
    <g:message code="header.loggedInAs"/> <span class="bold">${currentEntity?.profile?.fullName}</span>
    <g:link controller="security" action='logout'><img src="${g.resource(dir:'images/icons', file:'icon_logout.png')}" alt="Achtung" align="top"/>%{-- [<g:message code="header.logOut"/>]--}%</g:link><br/>
  </erp:isLoggedIn>
</div>
