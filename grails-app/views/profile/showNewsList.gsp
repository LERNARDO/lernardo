<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="newsp"/></title>
</head>
<body>
%{--<g:if test="${entity.profile.showTips}">
  <div class="toolTip" id="tooltip">
    <div class="second">
      <span class="bold"><img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><g:message code="hint"/></span> <g:message code="tooltip.news"/>
      <span style="float: right"><a onclick="toggle('#tooltip'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'cross.png')}" alt="Close"/></a></span>
    </div>
  </div>
</g:if>--}%
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="newsp"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:if test="${!newsList}">
      <div class="info-msg">
        <g:message code="news.noneYet"/>
      </div>
    </g:if>
    <g:else>
      <p><g:message code="object.total" args="[newsCount, message(code: 'news')]"/></p>
      <table class="default-table">
        <thead>
        <tr>
          <g:sortableColumn property="title" title="Titel"/>
          <g:sortableColumn property="dateCreated" title="Datum"/>
        </tr>
        </thead>
        <tbody>

        <g:each status="i" in="${newsList}" var="news">
          <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <td><g:link controller="news" action="show" id="${news.id}">${news.title}</g:link></td>
            <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${news.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
          </tr>
        </g:each>

        </tbody>
      </table>
    </g:else>

    <g:if test="${newsCount > 0}">
      <div class="paginateButtons">
        <g:paginate action="showNewsList" total="${newsCount}" params="[name: entity.name]"/>
      </div>
    </g:if>

  </div>
</div>
</body>

