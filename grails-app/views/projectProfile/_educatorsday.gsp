<g:if test="${educators}">
  <ul>
    <g:each in="${educators}" var="educator" status="i">
      <li style="margin-left: 15px">
        <g:link controller="${educator.type.supertype.name + 'Profile'}" action="show" id="${educator.id}">${educator.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeEducatorDay" update="educators2" id="${project.id}" params="[educator: educator.id, day: day.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
        <span id="tageducator${i}">
          <erp:getLocalTags entity="${educator}" target="${day}">
            <g:render template="/app/localtags" model="[entity: educator, target: day, tags: tags, update: 'tageducator' + i]"/>
          </erp:getLocalTags>
        </span>
      </li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="educators.choose"/></span>
</g:else>