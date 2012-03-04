<g:if test="${template.profile.resources}">
  <g:each in="${template.profile.resources}" var="resourceInstance" status="i">
    <div id="resource${i}" style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
      <g:render template="/requiredResources/showresource" model="[resourceInstance: resourceInstance, i: i, template: template]"/>
    </div>
  </g:each>
</g:if>
<g:else>
  <span class="italic red"><g:message code="resource.profile.empty"/></span>
</g:else>