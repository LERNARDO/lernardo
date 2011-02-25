<div class="header">
  <div class="title">
    <g:link action="show" id="${article.id}">${article.title}</g:link>
  </div>
  <div class="info">
    <g:message code="from"/> <span class="bold">
      <erp:isNotLoggedIn>
        ${article.author.profile.fullName}
      </erp:isNotLoggedIn>
      <erp:isLoggedIn>
        <erp:isEnabled entity="${article.author}">
          <g:link controller="${article.author.type.supertype.name +'Profile'}" action="show" id="${article.author.id}">${article.author.profile.fullName}</g:link>
        </erp:isEnabled>
        <erp:notEnabled entity="${article.author}">
          <span class="notEnabled">${article.author.profile.fullName}</span>
        </erp:notEnabled>
      </erp:isLoggedIn></span>
    <g:message code="atDate"/> <g:formatDate format="dd. MMM. yyyy" date="${article.dateCreated}"/>
    <g:message code="atTime"/> <g:formatDate format="HH:mm" date="${article.dateCreated}"/>
    <erp:isLoggedIn>
      <erp:isMeOrAdminOrOperator entity="${article.author}" current="${currentEntity}">
        (<g:link class="adminlink" action="edit" id="${article.id}"><g:message code="edit"/></g:link> -
         <g:link class="adminlink" action="delete" onclick="return confirm('Artikel wirklich löschen?');" id="${article.id}"><g:message code="delete"/></g:link>)
      </erp:isMeOrAdminOrOperator>
    </erp:isLoggedIn>
  </div>
</div>