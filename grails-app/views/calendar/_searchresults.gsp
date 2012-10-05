<ul>
  <g:each in="${results}" var="searchInstance">
    <li><g:link controller="calendar" action="addEntity" id="${searchInstance.id}">${searchInstance.profile}</g:link><br/><span class="gray"><g:message code="${searchInstance.type.supertype.name}"/></span></li>
  </g:each>
</ul>