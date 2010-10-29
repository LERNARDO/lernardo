<g:if test="${projects}">
  <ul>
  <g:each in="${projects}" var="project">
    <li><g:link controller="${project.type.supertype.name +'Profile'}" action="show" id="${project.id}" params="[entity:project.id]">${project.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeProject" update="projects2" id="${theme.id}" params="[project: project.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Projekt entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Keine Projekte zugewiesen! %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>