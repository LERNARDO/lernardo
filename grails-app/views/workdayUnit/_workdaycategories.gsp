<g:if test="${workdaycategories}">
  <ul>
  <g:each in="${workdaycategories}" var="category">
    <li>${category.name} <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><g:remoteLink action="removeCategory" update="workdaycategories2" id="${category.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Kategorie entfernen" align="top"/></g:remoteLink></app:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Keine Kategorien vorhanden!</span>
</g:else>