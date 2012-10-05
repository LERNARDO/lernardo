<g:if test="${facilities}">
  <ul>
  <g:each in="${facilities}" var="facility">
    <li><g:link controller="${facility.type.supertype.name + 'Profile'}" action="show" id="${facility.id}">${facility.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeFacility" update="facilities2" id="${project.id}" params="[facility: facility.id]" before="if(!confirm('${message(code:'groupActivity.removeFacility')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="facility.choose"/></span>
</g:else>

<script type="text/javascript">
  ${remoteFunction(update: "projectDay", action: "setprojectday", params: [project: project.id])}
</script>