<ul>
  <g:each in="${themes}" var="theme">
    <li><g:link controller="${theme.type.supertype.name +'Profile'}" action="show" id="${theme.id}" params="[entity:theme.id]">${theme.profile.fullName}</g:link> - <g:formatDate date="${theme.profile.startDate}" format="dd. MM. yyyy"/> bis <g:formatDate date="${theme.profile.endDate}" format="dd. MM. yyyy"/></li>
    <app:getSubThemes theme="${theme}">
      <g:render template="themes" model="[themes: subthemes]"/>
    </app:getSubThemes>
  </g:each>
</ul>