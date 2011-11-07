<g:link controller="app" action="start"><div id="logo">${grailsApplication.config.application.name}</div><img src="${resource(dir: '/images/' + grailsApplication.config.customer, file:  'logo.png')}" height="70px" alt="${grailsApplication.config.customer}"/></g:link>
<div id="info">
    %{--<g:form name="search">
    <g:textField class="search" name="search" size="30" placeholder="${message(code: 'searchWord')}"/>
    <span class="searchButton"><g:submitButton name="search" class="buttonBlue" value="${message(code: 'search')}"/></span>--}%
    <a href="?lang=de"><img src="${g.resource(dir:'images/icons', file:'flag_at.png')}" alt="German"/></a> <a href="?lang=es"><img src="${g.resource(dir:'images/icons', file:'flag_mx.png')}" alt="Spanish"/> <a href="?lang=en"><img src="${g.resource(dir:'images/icons', file:'flag_gb.png')}" alt="English"/></a>
    ${currentEntity?.profile?.fullName}
    <g:link controller="security" action='logout'><img src="${g.resource(dir:'images/icons', file:'icon_logout.png')}" alt="Logout" /></g:link>
    %{--</g:form>--}%
</div>
