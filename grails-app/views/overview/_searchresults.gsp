<p class="gray"><g:message code="maxResultsShown" args="[30]"/></p>
<g:each in="${results}" var="searchInstance">
  <g:render template="/templates/member" model="[entity: searchInstance]"/>
</g:each>
<div class="clear"></div>