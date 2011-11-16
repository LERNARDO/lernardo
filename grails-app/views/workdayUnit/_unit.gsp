<div class="gray" style="width: 200px; float: left;">
  <g:if test="${currentEntity.id == entity.id}">
    <g:if test="${!unit.confirmed}">
      <g:remoteLink action="editUnit" update="unit-${i}" id="${unit.id}" params="[i: i, entity: entity.id]"><img src="${g.resource(dir:'images/icons', file:'icon_edit2.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink> <g:remoteLink action="removeUnit" update="unit-${i}" id="${unit.id}" params="[entity: entity.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'cross.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
    </g:if>
  </g:if>
  <g:formatDate date="${unit.date1}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> - <g:formatDate date="${unit.date2}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
</div>
<div class="gray" style="width: 200px; float: left;">${unit.category}</div>
<div style="float: left;">${unit.description ? unit.description.decodeHTML() : '<span class="italic">' + message(code:'noData') + '</span>'}</div>
