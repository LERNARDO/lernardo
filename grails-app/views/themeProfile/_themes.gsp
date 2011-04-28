<ul>
  <g:each in="${themes}" var="theme">
    <li><g:link controller="${theme.type.supertype.name +'Profile'}" action="show" id="${theme.id}" params="[entity:theme.id]">${theme.profile.fullName}</g:link> - <g:formatDate date="${theme.profile.startDate}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> bis <g:formatDate date="${theme.profile.endDate}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></li>
    <erp:getSubThemes theme="${theme}">
      <g:render template="themes" model="[themes: subthemes]"/>
    </erp:getSubThemes>
  </g:each>
</ul>