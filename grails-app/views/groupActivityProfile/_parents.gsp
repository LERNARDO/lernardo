<g:if test="${parents}">
  <ul>
  <g:each in="${parents}" var="parent" status="i">
    <li>
      <g:link controller="${parent.type.supertype.name +'Profile'}" action="show" id="${parent.id}" params="[parent:parent.id]">${parent.profile.fullName}</g:link> <app:isCreator entity="${group}"><g:remoteLink action="removeParent" update="parents2" id="${group.id}" params="[parent: parent.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Erziehungsberechtigten entfernen" align="top"/></g:remoteLink></app:isCreator>
      %{--<span id="tagparent${i}">
        <app:getTags entity="${parent}">
          <g:render template="/app/tags" model="[entity: parent, tags: tags, update: 'tagparent'+ i]"/>
        </app:getTags>
      </span>--}%
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Keine Erziehungsberechtigten zugewiesen! %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>