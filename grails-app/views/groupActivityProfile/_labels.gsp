<g:if test="${group.profile.labels}">
  <g:each in="${group.profile.labels}" var="label">
    <span class="tag">
      <span class="tail"></span>
      <span class="hole"></span>
      ${label.name} <erp:accessCheck types="['Betreiber','Pädagoge']" creatorof="${group}" checkoperator="true"><g:remoteLink action="removeLabel" update="labels2" id="${group.id}" params="[label: label.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false">(entfernen)</g:remoteLink></erp:accessCheck>
    </span>
  </g:each>
</g:if>
<g:else>
  <span class="italic red"><g:message code="labels.empty"/></span>
</g:else>

<erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${group}" checkoperator="true"><a onclick="jQuery('#labels').toggleClass('hidden').toggleClass('visible');" href="#"><img src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck>