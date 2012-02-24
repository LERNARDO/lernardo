<g:if test="${template.profile.aresources}">
  <g:each in="${template.profile.aresources}" var="resource" status="i">
    <div id="resource${i}" style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
      <g:render template="/requiredResources/showresource" model="[resource: resource, i: i, entity: entity, template: template]"/>
    </div>
  </g:each>
</g:if>
<g:else>
  <span class="italic red"><g:message code="resource.profile.empty"/></span>
</g:else>