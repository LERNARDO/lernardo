<g:if test="${projects}">
  <ul>
  <g:each in="${projects}" var="project">
    <li><g:link controller="${project.type.supertype.name + 'Profile'}" action="show" id="${project.id}">${project.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']"><g:remoteLink action="removeProject" update="projects2" id="${theme.id}" params="[project: project.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="projects.notAssigned"/></span>
</g:else>