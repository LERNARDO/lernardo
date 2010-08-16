<g:if test="${groupActivityTemplates}">
  <div style="margin-left: 15px">
  <ul>
    <g:each in="${groupActivityTemplates}" var="groupActivityTemplate">
      <li><g:link controller="${groupActivityTemplate.type.supertype.name +'Profile'}" action="show" id="${groupActivityTemplate.id}" params="[entity:groupActivityTemplate.id]">${groupActivityTemplate.profile.fullName} (${groupActivityTemplate.profile.realDuration}min)</g:link> <g:remoteLink action="removeGroupActivityTemplate" update="groups2-${i}" id="${unit.id}" params="[groupActivityTemplate: groupActivityTemplate.id, i: i]" before="if(!confirm('${message(code:'delete.warn')}')) return false; showspinner('#groups2${i}')"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Aktivitätsblockvorlage entfernen" align="top"/></g:remoteLink></li>
    </g:each>
  </ul>
  </div>
</g:if>
<g:else>
  <span class="italic" style="margin: 0 0 0 15px">Keine Aktivitätsblockvorlagen zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>