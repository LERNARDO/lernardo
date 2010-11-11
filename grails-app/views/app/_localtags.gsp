<g:if test="${tags}">
  <span class="tags">
    <g:if test="${tags[0]}">
      <span class="atag"><img src="${g.resource(dir:'images/icons', file:'tag_green.png')}" alt="Tag" align="top"/> Abwesend <g:remoteLink update="${update}" controller="app" action="removeLocalTag" params="[tag: 'absent', entity: entity.id, target: target.id, update: update]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Tag entfernen" align="top"/></g:remoteLink></span>
    </g:if>
    <g:if test="${tags[1]}">
      <span class="atag"><img src="${g.resource(dir:'images/icons', file:'tag_green.png')}" alt="Tag" align="top"/> Krank <g:remoteLink update="${update}" controller="app" action="removeLocalTag" params="[tag: 'ill', entity: entity.id, target: target.id, update: update]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Tag entfernen" align="top"/></g:remoteLink></span>
    </g:if>
  </span>
</g:if>

<span class="tagbuttons">
  <g:if test="${!tags[0]}">
    <g:remoteLink update="${update}" controller="app" action="addLocalTag" params="[entity: entity.id, target: target.id, tag: 'absent', update: update]">abwesend markieren</g:remoteLink>
  </g:if>

  <app:accessCheck entity="${entity}" roles="[]" types="['Pädagoge','Betreuter']" me="false">
    <g:if test="${!tags[1]}">
      | <g:remoteLink update="${update}" controller="app" action="addLocalTag" params="[entity: entity.id, target: target.id, tag: 'ill', update: update]">krank markieren</g:remoteLink>
    </g:if>
  </app:accessCheck>
</span>