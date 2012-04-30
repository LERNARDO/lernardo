<ul>
  <g:each in="${themes}" var="theme">
    <li style="line-height: 22px;"><g:link controller="${theme.type.supertype.name + 'Profile'}" action="show" id="${theme.id}">${theme.profile.fullName.decodeHTML()}</g:link> - <g:formatDate date="${theme.profile.startDate}" format="dd. MMMM yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <span class="gray"><g:message code="to"/></span> <g:formatDate date="${theme.profile.endDate}" format="dd. MMMM yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></li>
    <erp:getSubThemes theme="${theme}">
      <g:render template="themes" model="[themes: subthemes]"/>
    </erp:getSubThemes>
  </g:each>
</ul>