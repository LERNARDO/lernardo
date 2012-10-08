<head>
  <meta name="layout" content="start"/>
  <title><g:message code="searchResults"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="searchResults"/></h1>
</div>

<p><span class="gray"><g:message code="searchWord"/>:</span> "${search}"</p>

<g:if test="${results}">
  <p class="gray"><g:message code="maxResultsShown" args="[100]"/></p>
  <g:each in="${results}" var="searchInstance">
    <g:render template="/templates/member" model="[entity: searchInstance]"/>
  </g:each>
  <div class="clear"></div>
</g:if>
<g:else>
  <span class="italic"><g:message code="noResultsFound"/></span>
</g:else>

</body>