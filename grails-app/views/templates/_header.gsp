%{--<div style="clear: both;"></div>--}%
%{--<a href="${g.resource(dir:'')}"><div id="logo"></div></a>--}%
<g:link controller="app" action="start"><div id="logo">${grailsApplication.config.application.name}</div><img src="${resource(dir: '/images/' + grailsApplication.config.customer, file:  'logo.png')}" height="70px"/></g:link>
<div id="info">
  <erp:isLoggedIn>
    <a href="?lang=de"><img src="${g.resource(dir:'images/icons', file:'flag_at.png')}" alt="German"/></a> <a href="?lang=es"><img src="${g.resource(dir:'images/icons', file:'flag_mx.png')}" alt="Spanish"/> <a href="?lang=en"><img src="${g.resource(dir:'images/icons', file:'flag_gb.png')}" alt="English"/></a>
    <g:message code="header.loggedInAs"/> <span class="bold">${currentEntity?.profile?.fullName}</span>
    <g:link controller="security" action='logout'><img src="${g.resource(dir:'images/icons', file:'icon_logout.png')}" alt="Logout" align="top"/></g:link><br/>
  </erp:isLoggedIn>
</div>
