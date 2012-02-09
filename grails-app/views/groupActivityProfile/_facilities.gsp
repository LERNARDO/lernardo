<g:if test="${facilities}">
  <ul>
  <g:each in="${facilities}" var="facility">
    <li><g:link controller="${facility.type.supertype.name +'Profile'}" action="show" id="${facility.id}">${facility.profile.fullName.decodeHTML()}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${group}"><g:remoteLink action="removeFacility" update="facilities2" id="${group.id}" params="[facility: facility.id]" before="if(!confirm('${message(code:'groupActivity.removeFacility')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="facilities.notAssigned"/></span>
</g:else>

<script type="text/javascript">
  ${remoteFunction(update: "resources2", action: "refreshplannedresources", id: group.id)}
</script>