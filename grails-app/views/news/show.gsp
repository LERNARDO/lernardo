<head>
  <title><g:message code="news"/></title>
  <meta name="layout" content="start"/>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="news"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

  <div id="news-container">
    <div class="item">
      <div class="header">
        <div class="title">
          <g:link controller="news" action="show" id="${news.id}">${news.title}</g:link> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${news.author}">
            <g:link controller="news" action="edit" id="${news.id}"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" /></g:link>
             <g:link controller="news" action="delete" class="adminlink" onclick="return confirm('Neuigkeit wirklich löschen?');" id="${news.id}"><img src="${resource(dir: 'images/icons', file: 'cross.png')}" alt="${message(code: 'remove')}" /></g:link>
          </erp:accessCheck>
        </div>
        <div class="info">
          <g:message code="from"/>
          <span class="bold">
            <g:link controller="${news.author.type.supertype.name +'Profile'}" action="show" id="${news.author.id}">${news.author.profile.fullName}</g:link>
          </span>
          <g:message code="atDate"/> <g:formatDate format="dd. MMM. yyyy" date="${news.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
          <g:message code="atTime"/> <g:formatDate format="HH:mm" date="${news.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
        </div>
      </div>
      <g:if test="${news.teaser}">
        <div class="teaser">
          <g:if test="${news.teaser}">
            <p>${news.teaser.decodeHTML()}</p>
          </g:if>
        </div>
      </g:if>
      <div class="content">
        <g:if test="${news.content}">
          ${news.content.decodeHTML()}
        </g:if>
      </div>
      <div class="links">
        <g:link controller="event" action="index">&#187; <g:message code="backToList"/></g:link>
      </div>
    </div>
  </div>
  </div>
</div>
</body>
