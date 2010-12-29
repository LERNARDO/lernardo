<g:if test="${substitutes}">
  <ul>
    <g:each in="${substitutes}" var="substitute" status="i">
      <li style="margin-left: 15px">
        <g:link controller="${substitute.type.supertype.name +'Profile'}" action="show" id="${substitute.id}" params="[entity:substitute.id]">${substitute.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeSubstitute" update="substitutes2" id="${projectDay.id}" params="[substitute: substitute.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Supplierung entfernen" align="top"/></g:remoteLink></erp:accessCheck>
        <span id="tagsubstitute${i}">
          <erp:getLocalTags entity="${substitute}" target="${projectDay}">
            <g:render template="/app/localtags" model="[entity: substitute, target: projectDay, tags: tags, update: 'tagsubstitute' + i]"/>
          </erp:getLocalTags>
        </span>
      </li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Bitte die Ersatzpädagogen auswählen, die an diesem Projekttag teilnehmen!%{--Keine Pädagogen zugewiesen--}% %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>