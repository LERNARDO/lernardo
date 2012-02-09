<g:if test="${resources}">
  <g:each in="${resources}" var="resource">
    <div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
      <ul>
        <li style="list-style-type: none"><span class="bold"><g:message code="name"/>:</span> <g:link controller="${resource.type.supertype.name +'Profile'}" action="show" id="${resource.id}">${resource.profile.fullName.decodeHTML()}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']"><g:remoteLink action="unplanresource" update="resources2" id="${projectDay.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
        <li style="list-style-type: none"><g:message code="resource.profile.amount"/>: <erp:getPlannedResourceAmount resource="${resource}" entity="${projectDay}"/></li>
      </ul>
    </div>
  </g:each>
</g:if>
<g:else>
  <span class="italic red"><g:message code="resource.profile.notPlanned"/></span>
</g:else>

<script type="text/javascript">
  ${remoteFunction(update: "plannableresources", action: "refreshplannableresources", id: projectDay.id)}
</script>