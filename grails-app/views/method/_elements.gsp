<g:if test="${methodInstance.elements}">
  <g:each in="${methodInstance.elements}" var="element" status="i">
    <div id="element${i}">
      <g:render template="element" model="[element: element, i: i, entity: entity]"/>
    </div>
  </g:each>
</g:if>
<g:else>
  <span class="italic red"><g:message code="elements.notAssigned"/></span>
</g:else>