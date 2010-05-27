<ul>
  <g:each in="${groupActivityTemplates}" var="groupActivityTemplate">
    <li><g:link controller="${groupActivityTemplate.type.supertype.name +'Profile'}" action="show" id="${groupActivityTemplate.id}" params="[entity:groupActivityTemplate.id]">${groupActivityTemplate.profile.fullName} (${groupActivityTemplate.profile.realDuration}min)</g:link> <g:remoteLink action="removeGroupActivityTemplate" update="groups2${i}" id="${unit.id}" params="[groupActivityTemplate: groupActivityTemplate.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Aktivitätsvorlagengruppe entfernen" align="top"/></g:remoteLink></li>
  </g:each>
</ul>