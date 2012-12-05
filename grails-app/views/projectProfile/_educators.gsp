<g:if test="${educators}">
  <ul>
    <g:each in="${educators}" var="educator" status="i">
      <li style="margin-left: 15px">
        <g:link controller="${educator.type.supertype.name + 'Profile'}" action="show" id="${educator.id}">${educator.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeEducator" update="educators2" id="${project.id}" params="[educator: educator.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
      </li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="educators.choose"/></span>
</g:else>