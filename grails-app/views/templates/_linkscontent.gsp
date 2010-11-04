<div style="margin: 5px">
  <g:if test="${list}">
    <ul>
      <g:each in="${list}" var="entity">
        <li style="list-style-type: disc"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity: entity.id]">${entity.profile.fullName}</g:link></li>
      </g:each>
    </ul>
  </g:if>
  <g:else>
    Keine Verlinkungen gefunden!
  </g:else>
</div>