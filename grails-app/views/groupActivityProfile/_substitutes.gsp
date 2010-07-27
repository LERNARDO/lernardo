<g:if test="${substitutes}">
  <ul>
  <g:each in="${substitutes}" var="substitute" status="i">
    <li>
      <g:link controller="${substitute.type.supertype.name +'Profile'}" action="show" id="${substitute.id}" params="[entity:substitute.id]">${substitute.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeSubstitute" update="substitutes2" id="${group.id}" params="[substitute: substitute.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Supplierung entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin>
      %{--<span id="tageducator${i}">
        <app:getTags entity="${substitute}">
          <g:render template="/app/tags" model="[entity: substitute, tags: tags, update: 'tagsubstitute'+ i]"/>
        </app:getTags>
      </span>--}%
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Supplierungen zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>