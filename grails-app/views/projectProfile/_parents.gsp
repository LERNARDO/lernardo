<g:if test="${parents}">
  <ul style="margin-left: 15px">
    <g:each in="${parents}" var="parent" status="j">
      <li>
        <g:link controller="${parent.type.supertype.name + 'Profile'}" action="show" id="${parent.id}">${parent.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeParent" update="parents2${i}" id="${unit.id}" params="[parent: parent.id, i:i]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
        <span id="tagparent${i}_${j}">
          <erp:getLocalTags entity="${parent}" target="${unit}">
            <g:render template="/app/localtags" model="[entity: parent, target: unit, tags: tags, update: 'tagparent' + i + '_' + j]"/>
          </erp:getLocalTags>
        </span>
      </li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="parents.choose"/></span>
</g:else>