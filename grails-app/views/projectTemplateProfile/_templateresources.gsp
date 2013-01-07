<p><span class="bold"><g:message code="resourcesFromActivityTemplates"/>:</span> <g:remoteLink update="templateresources" action="refreshtemplateresources" id="${projectTemplate.id}" before="showspinner('#templateresources')"><img src="${g.resource(dir:'images/icons', file:'arrow_refresh.png')}" alt="Aktualisieren" align="top"/></g:remoteLink></p>
    <div class="zusatz-show">
  <g:if test="${templateResources}">
    <g:each in="${templateResources}" var="resource">
      <div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
        <ul>
          <li><span class="bold"><g:message code="name"/>:</span> ${resource.name}</li>
          <li><g:message code="description"/>: ${resource.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
          <li><g:message code="resource.profile.amount"/>: ${resource.amount}</li>
        </ul>
      </div>
    </g:each>
  </g:if>
  <g:else>
    <span class="italic red"><g:message code="noResourcesOfTemplates"/></span>
  </g:else>
</div>