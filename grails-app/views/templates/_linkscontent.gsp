<g:if test="${list}">
  <ul style="margin: 0; padding: 0;">
    <g:each in="${list}" var="entity">
      <li style="list-style-type: disc"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}">${entity.profile.fullName.decodeHTML()}</g:link></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="gray"><g:message code="links.notFound"/></span>
</g:else>