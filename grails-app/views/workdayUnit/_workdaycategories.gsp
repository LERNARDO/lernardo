<g:if test="${workdaycategories}">
  <ul>
  <g:each in="${workdaycategories}" var="category">
    <li>${category.name} <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']"><g:remoteLink action="removeCategory" update="workdaycategories2" id="${category.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Kategorie entfernen" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="workdayCategories.none"/></span>
</g:else>