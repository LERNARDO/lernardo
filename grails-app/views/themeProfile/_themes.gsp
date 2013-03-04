<ul>
  <g:each in="${themes}" var="theme">
    <li style="line-height: 22px;"><g:link class="largetooltip" data-idd="${theme.id}" controller="${theme.type.supertype.name + 'Profile'}" action="show" id="${theme.id}">${theme.profile.decodeHTML()}</g:link> - <g:formatDate date="${theme.profile.startDate}" format="dd. MMMM yyyy"/> <span class="gray"><g:message code="to"/></span> <g:formatDate date="${theme.profile.endDate}" format="dd. MMMM yyyy"/></li>
    <erp:getSubThemes theme="${theme}">
      <g:render template="themes" model="[themes: subthemes]"/>
    </erp:getSubThemes>
  </g:each>
</ul>