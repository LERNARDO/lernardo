<g:if test="${tags}">
  <span class="tags">
    <g:if test="${tags[0]}">
      <span class="atag"><img src="${g.resource(dir:'images/icons', file:'tag_green.png')}" alt="Tag" align="top"/> <g:message code="absent"/> <g:remoteLink update="${update}" controller="app" action="removeLocalTag" params="[tag: 'absent', entity: entity.id, target: target.id, update: update, projectID: project.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></span>
    </g:if>
    <g:if test="${tags[1]}">
      <span class="atag"><img src="${g.resource(dir:'images/icons', file:'tag_green.png')}" alt="Tag" align="top"/> <g:message code="ill"/> <g:remoteLink update="${update}" controller="app" action="removeLocalTag" params="[tag: 'ill', entity: entity.id, target: target.id, update: update, projectID: project.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></span>
    </g:if>
  </span>
</g:if>

<span class="tagbuttons">
  <erp:accessCheck types="['Betreiber']" creatorof="${project}">
    <g:if test="${!tags[0]}">
    <g:remoteLink update="${update}" controller="app" action="addLocalTag" params="[entity: entity.id, target: target.id, tag: 'absent', update: update, projectID: project.id]"><g:message code="tag.asAbsent"/></g:remoteLink>
    </g:if>
    <g:if test="${!tags[1]}">
      | <g:remoteLink update="${update}" controller="app" action="addLocalTag" params="[entity: entity.id, target: target.id, tag: 'ill', update: update, projectID: project.id]"><g:message code="tag.asIll"/></g:remoteLink>
    </g:if>
  </erp:accessCheck>
</span>