<g:if test="${template.profile.methods}">
  <%
    def methods = template.profile.methods.toList().sort {it.name}
  %>
  <g:each in="${methods}" var="method">
    <ul style="padding-bottom: 5px; margin-bottom: 5px; border-bottom: 1px dashed #ccc;">
      <li style="padding: 5px 0;">${method.name} <erp:accessCheck types="['Betreiber','Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><g:remoteLink action="removeMethod" update="methods2" id="${template.id}" params="[method: method.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
      <g:each in="${method.elements}" var="element">
        <li style="padding-left: 15px;"><div id="starBox${element.id}" class="starbox"><erp:starBox element="${element.id}" template="${template}"/></div></li>
      </g:each>
    </ul>
  </g:each> 
</g:if>
<g:else>
  <span class="italic red"><g:message code="vMethods.empty"/></span>
</g:else>