<div class="info-msg">
  <g:message code="object.found" args="[results.size(), message(code: 'educators')]"/>
</div>

<g:each in="${results}" var="result">
  <g:render template="/templates/member" model="[entity: result]"/>
</g:each>