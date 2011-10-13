<div style="clear: both;"></div>
<a href="${g.resource(dir:'')}"><div id="logo"></div></a>
<div id="info">
  <erp:isLoggedIn>
    <a href="?lang=de"><img src="${g.resource(dir:'images/icons', file:'flag_at.png')}" alt="German"/></a> <a href="?lang=es"><img src="${g.resource(dir:'images/icons', file:'flag_mx.png')}" alt="Spanish"/> <a href="?lang=en"><img src="${g.resource(dir:'images/icons', file:'flag_gb.png')}" alt="English"/></a>
    <g:message code="header.loggedInAs"/> <span class="bold">${currentEntity?.profile?.fullName}</span>
    <g:link controller="security" action='logout'><img src="${g.resource(dir:'images/icons', file:'icon_logout.png')}" alt="Logout" align="top"/></g:link><br/>
    <g:link controller="articlePost" action="index">Zum Start</g:link> - <g:link controller="app" action='start'>Zum ${grailsApplication.config.application.name}</g:link>
  </erp:isLoggedIn>
</div>
