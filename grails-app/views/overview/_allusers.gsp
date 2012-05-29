<head></head><div class="userlist-results">
    <g:render template="glossary" model="[glossary: glossary]"/>

    <g:if test="${entities.size() == 0}">
      <span class="italic red"><g:message code="profile.overview.search.empty"/></span>
    </g:if>
    <g:each in="${entities}" var="entity">
      <g:render template="/templates/member" model="[entity: entity]"/>
    </g:each>

    <div class="clear"></div>

    <g:if test="${numEntities > 16}">
      <div class="paginateButtons">
        <util:remotePaginate action="showUsers" total="${numEntities}" update="userlist-results" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}" params="[glossary:glossary]"/>
      </div>
    </g:if>

</div>