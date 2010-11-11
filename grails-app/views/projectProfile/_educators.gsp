<g:if test="${educators}">
  <ul>
    <g:each in="${educators}" var="educator" status="i">
      <li>
        <g:link controller="${educator.type.supertype.name +'Profile'}" action="show" id="${educator.id}" params="[entity:educator.id]">${educator.profile.fullName}</g:link> <app:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><g:remoteLink action="removeEducator" update="educators2" id="${projectDay.id}" params="[educator: educator.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Pädagoge entfernen" align="top"/></g:remoteLink></app:accessCheck>
        <span id="tageducator${i}">
          <app:getLocalTags entity="${educator}" target="${projectDay}">
            <g:render template="/app/localtags" model="[entity: educator, target: projectDay, tags: tags, update: 'tageducator' + i]"/>
          </app:getLocalTags>
        </span>
      </li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Bitte die Pädagogen auswählen, die an diesem Projekttag teilnehmen!%{--Keine Pädagogen zugewiesen--}% %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>