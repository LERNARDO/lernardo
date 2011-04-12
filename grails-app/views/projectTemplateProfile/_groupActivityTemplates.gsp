<g:if test="${groupActivityTemplates}">
  <div style="margin-left: 30px">
  <ul>
    <g:each in="${groupActivityTemplates}" var="groupActivityTemplate">
      <li><g:link controller="${groupActivityTemplate.type.supertype.name +'Profile'}" action="show" id="${groupActivityTemplate.id}" params="[entity:groupActivityTemplate.id]">${groupActivityTemplate.profile.fullName} (${groupActivityTemplate.profile.realDuration}min)</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${projectTemplate}"><g:remoteLink action="removeGroupActivityTemplate" update="groups2-${i}" id="${unit.id}" params="[groupActivityTemplate: groupActivityTemplate.id, i: i, projectTemplate: projectTemplate.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false; showspinner('#groups2${i}')" after="${remoteFunction(action:'updateduration',update:'updateduration', id: projectTemplate.id)}"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Aktivitätsblockvorlage entfernen" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
  </div>
</g:if>
<g:else>
  <span class="italic red" style="margin-left: 15px"><g:message code="groupActivityTemplates.notAssigned"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>