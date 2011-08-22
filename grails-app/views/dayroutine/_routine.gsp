<table>
  <tr>
    <td class="bold" valign="top" style="width: 125px;"><g:formatDate date="${routine.dateFrom}" format="H:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> - <g:formatDate date="${routine.dateTo}" format="H:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
    <td valign="top">
      ${routine.title} <g:remoteLink update="${'routinebox' + i}" action="editroutine" id="${routine.id}" params="[i: i]"><img src="${g.resource(dir:'images/icons', file:'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink> <g:remoteLink update="${'routinebox' + i}" action="deleteroutine" id="${routine.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink><br/>
      <div style="margin-top: 5px;">${routine.description ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</div>
    </td>
  </tr>
</table>