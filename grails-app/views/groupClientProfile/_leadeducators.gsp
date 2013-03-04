<g:if test="${leadeducators}">
  <ul>
    <g:each in="${leadeducators}" var="educator">
      <li><g:link controller="${educator.type.supertype.name + 'Profile'}" action="show" id="${educator.id}">${educator.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']" creatorof="${group}"><g:remoteLink action="removeLeadEducator" update="leadeducators2" id="${group.id}" params="[leadeducator: educator.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="leadEducators.empty"/></span>
</g:else>