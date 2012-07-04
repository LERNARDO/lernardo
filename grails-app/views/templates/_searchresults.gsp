<div class="info-msg">
  <g:message code="object.found" args="[totalResults, message(code: 'searchResults')]"/>
</div>

<g:each in="${results}" var="result" status="i">
  <g:render template="/templates/member" model="[entity: result, i: i]"/>
</g:each>
<div class="clear"></div>

<div class="paginateButtons">
  <util:remotePaginate controller="${type}Profile" action="define" total="${totalResults}" update="searchresults" before="showspinner('#searchresults')" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}" params="${params}"/>
</div>