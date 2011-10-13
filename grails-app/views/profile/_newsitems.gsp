<g:each in="${news}" var="article">
  <div class="item">
    <div class="header">
      <div class="title">
        <g:link controller="articlePost" action="show" id="${article.id}">${article.title}</g:link> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${article.author}">
          <g:link controller="articlePost" action="edit" id="${article.id}"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" /></g:link>
           <g:link controller="articlePost" action="delete" class="adminlink" onclick="return confirm('Neuigkeit wirklich löschen?');" id="${article.id}"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code: 'remove')}" /></g:link>
        </erp:accessCheck>
      </div>
      <div class="info">
        <g:message code="from"/> <span class="bold">
            <erp:isEnabled entity="${article.author}">
              <g:link controller="${article.author.type.supertype.name +'Profile'}" action="show" id="${article.author.id}">${article.author.profile.fullName}</g:link>
            </erp:isEnabled>
            <erp:notEnabled entity="${article.author}">
              <span class="notEnabled">${article.author.profile.fullName}</span>
            </erp:notEnabled>
          </span>
        <g:message code="atDate"/> <g:formatDate format="dd. MMM. yyyy" date="${article.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
        <g:message code="atTime"/> <g:formatDate format="HH:mm" date="${article.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>

      </div>
    </div>
    <g:if test="${article.teaser}">
      <div class="teaser">
        <g:if test="${article.teaser}">
          <p>${article.teaser.decodeHTML()}</p>
        </g:if>
      </div>
    </g:if>
    <g:else>
      <div class="content">
        <g:if test="${article.content}">
          ${article.content.decodeHTML()}
        </g:if>
      </div>
    </g:else>
    <div class="links">
      <g:if test="${article.teaser}">
        <g:link controller="articlePost" action="show" id="${article.id}">&#187; <g:message code="showMore"/></g:link>
      </g:if>
    </div>
  </div>
</g:each>

<div class="paginateButtons">
  <util:remotePaginate action="getNews" total="${newsCount}" update="article-container" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}"/>
</div>