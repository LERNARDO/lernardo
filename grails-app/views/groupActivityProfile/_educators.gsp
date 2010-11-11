<g:if test="${educators}">
  <ul>
  <g:each in="${educators}" var="educator" status="i">
    <li>
      <g:link controller="${educator.type.supertype.name +'Profile'}" action="show" id="${educator.id}" params="[entity:educator.id]">${educator.profile.fullName}</g:link> <app:isCreator entity="${group}"><g:remoteLink action="removeEducator" update="educators2" id="${group.id}" params="[educator: educator.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Pädagogen entfernen" align="top"/></g:remoteLink></app:isCreator>
      <span id="tageducator${i}">
        <app:getLocalTags entity="${educator}" target="${group}">
          <g:render template="/app/localtags" model="[entity: educator, target: group, tags: tags, update: 'tageducator' + i]"/>
        </app:getLocalTags>
      </span>
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Keine Pädagogen zugewiesen! %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>