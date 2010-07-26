<g:if test="${tags}">
  <span class="tags">
    <g:each in="${tags}" var="tag">
      <span class="atag"><img src="${g.resource(dir:'images/icons', file:'tag_green.png')}" alt="Tag hinzufügen" align="top"/> ${tag.name} <g:remoteLink update="${update}" controller="app" action="removeTag" params="[tag: tag.id, entity: entity.id, update: update]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Tag entfernen" align="top"/></g:remoteLink></span>
    </g:each>
  </span>
</g:if>
%{--<g:remoteLink update="${update}" controller="app" action="addTag" params="[entity: entity.id, update: update]">
  <img src="${g.resource(dir:'images/icons', file:'tag_green.png')}" alt="Tag hinzufügen" align="top"/>
</g:remoteLink>--}%


<span class="tagbuttons">
  <g:remoteLink update="${update}" controller="app" action="addTag" params="[entity: entity.id, tag: 'abwesend', update: update]">war abwesend</g:remoteLink> -
  <g:remoteLink update="${update}" controller="app" action="addTag" params="[entity: entity.id, tag: 'krank', update: update]">war krank</g:remoteLink>
</span>