<g:if test="${tags}">
  <span class="tags">
    <g:each in="${tags}" var="tag">
      <span class="atag"><img src="${g.resource(dir:'images/icons', file:'tag_green.png')}" alt="${message(code: 'add')}" align="top"/> ${tag.name} <g:remoteLink update="${update}" controller="app" action="removeTag" params="[tag: tag.id, entity: entity.id, update: update]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></span>
    </g:each>
  </span>
</g:if>
%{--<g:remoteLink update="${update}" controller="app" action="addTag" params="[entity: entity.id, update: update]">
  <img src="${g.resource(dir:'images/icons', file:'tag_green.png')}" alt="${message(code: 'add')}" align="top"/>
</g:remoteLink>--}%


<span class="tagbuttons">

  <erp:showTagButton tags="${tags}" button="abwesend">
    <g:remoteLink update="${update}" controller="app" action="addTag" params="[entity: entity.id, tag: 'abwesend', update: update]">abwesend markieren</g:remoteLink>
  </erp:showTagButton>

  <erp:accessCheck entity="${entity}" types="['Pädagoge','Betreuter']">
    <erp:showTagButton tags="${tags}" button="krank">
      | <g:remoteLink update="${update}" controller="app" action="addTag" params="[entity: entity.id, tag: 'krank', update: update]">krank markieren</g:remoteLink>
    </erp:showTagButton>
  </erp:accessCheck>
</span>