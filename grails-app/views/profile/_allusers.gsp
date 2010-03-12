<head><g:javascript library="jquery" /></head><div class="userlist-results">
    <g:render template="glossary" model="[glossary: glossary]"/>

    <g:if test="${entities.size() == 0}">
      Keine Mitglieder gefunden!
    </g:if>
    <g:each in="${entities}" var="entity">
      <div class="member">

        <div class="member-pic">
          <g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">
            <ub:profileImage name="${entity.name}" width="50" height="50" align="left"/>
          </g:link>
        </div>
        
        <div class="member-info">
          <div class="member-name"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity:entity.id]">${entity.profile.fullName}</g:link></div>
          <div class="member-uni">${entity.type.name}</div>
        </div>

      </div>
    </g:each>

    <div class="clear"></div>

    <g:if test="${numEntities > 6}">
      <div class="paginateButtons">
        <util:remotePaginate action="showUsers" total="${numEntities}" update="userlist-results" next="Nächste Seite" prev="Vorherige Seite" params="[glossary:glossary]"/>
      </div>
    </g:if>

</div>