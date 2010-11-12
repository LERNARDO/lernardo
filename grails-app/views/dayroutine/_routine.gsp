<table>
  <tr>
    <td>
      ${routine.title} <g:remoteLink update="${'routinebox' + i}" action="editroutine" id="${routine.id}" params="[i: i]"><img src="${g.resource(dir:'images/icons', file:'icon_edit.png')}" alt="Eintrag bearbeiten" align="top"/></g:remoteLink> <g:remoteLink update="${'routinebox' + i}" action="deleteroutine" id="${routine.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Eintrag entfernen" align="top"/></g:remoteLink><br/>
      von <g:formatDate date="${routine.dateFrom}" format="HH:mm"/> Uhr bis <g:formatDate date="${routine.dateTo}" format="HH:mm"/> Uhr
    </td>
    <td>
      ${routine.description}
    </td>
  </tr>
</table>