<g:each in="${news}" var="newsitem">
  <div class="item">
    <div class="header">
      <div class="title">
        <g:link controller="news" action="show" id="${newsitem.id}">${newsitem.title}</g:link> <erp:accessCheck types="['Betreiber']" me="${newsitem.author}">
          <g:link controller="news" action="edit" id="${newsitem.id}"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" /></g:link>
           <g:link controller="news" action="delete" class="adminlink" onclick="return confirm('Neuigkeit wirklich löschen?');" id="${newsitem.id}"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code: 'remove')}" /></g:link>
        </erp:accessCheck>
      </div>
      <div class="info">
        <g:message code="from"/>
        <erp:isEnabled entity="${newsitem.author}">
          <g:link controller="${newsitem.author.type.supertype.name +'Profile'}" action="show" id="${newsitem.author.id}">${newsitem.author.profile.fullName}</g:link>
        </erp:isEnabled>
        <erp:notEnabled entity="${newsitem.author}">
          <span class="notEnabled">${newsitem.author.profile.fullName}</span>
        </erp:notEnabled>
        <g:message code="atDate"/> <g:formatDate format="dd. MMM. yyyy" date="${newsitem.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
        <g:message code="atTime"/> <g:formatDate format="HH:mm" date="${newsitem.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
      </div>
    </div>
    <g:if test="${newsitem.teaser}">
      <div class="teaser">
        <g:if test="${newsitem.teaser}">
          <p>${newsitem.teaser.decodeHTML()}</p>
        </g:if>
      </div>
    </g:if>
    <g:else>
      <div class="content">
        <g:if test="${newsitem.content}">
          ${newsitem.content.decodeHTML()}
        </g:if>
      </div>
    </g:else>
    <div class="links">
      <g:if test="${newsitem.teaser}">
        <g:link controller="news" action="show" id="${newsitem.id}">&#187; <g:message code="showMore"/></g:link>
      </g:if>
    </div>
  </div>
</g:each>

