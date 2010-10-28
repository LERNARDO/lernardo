<g:if test="${parents}">
  <ul>
    <g:each in="${parents}" var="parent">
      <li><g:link controller="${parent.type.supertype.name +'Profile'}" action="show" id="${parent.id}" params="[entity:parent.id]">${parent.profile.fullName}</g:link> <app:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeParent" update="parents2${i}" id="${unit.id}" params="[parent: parent.id, i:i]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Erziehungsberechtigten entfernen" align="top"/></g:remoteLink></app:accessCheck></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Bitte die Erziehungsberechtigten auswählen, die an dieser Projekteinheit teilnehmen!%{--Keine Erziehungsberechtigten zugewiesen--}% %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>