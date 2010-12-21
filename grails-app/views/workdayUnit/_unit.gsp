<g:formatDate date="${unit.date1}" format="HH:mm"/> bis <g:formatDate date="${unit.date2}" format="HH:mm"/>
<g:if test="${!unit.confirmed}">
  <g:remoteLink action="editUnit" update="unit-${i}" id="${unit.id}" params="[i: i]"><img src="${g.resource(dir:'images/icons', file:'icon_edit2.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink> <g:remoteLink action="removeUnit" update="unit-${i}" id="${unit.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
</g:if>
<br/>
Kategorie: ${unit.category}<br/>
Beschreibung: ${unit.description.decodeHTML()}<br/><br/>