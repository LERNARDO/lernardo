<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title><g:message code="articles"/></title>
</head>
<body>
<g:if test="${entity.profile.showTips}">
  <div class="toolTip" id="tooltip">
    <div class="second">
      <span class="bold"><img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><g:message code="hint"/></span> Diese Seite bietet einen Überblick über sämtliche von dir verfasste Artikel.
      <span style="float: right"><a onclick="toggle('#tooltip'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'cross.png')}" alt="Close"/></a></span>
    </div>
  </div>
</g:if>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="articles"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div id="body-list">

      <g:if test="${!articleList}">
        <g:message code="articles.noneYet"/>
      </g:if>
      <g:else>
        <p>${articleCount} <g:message code="articles.c_total"/></p>
        <table>
          <thead>
          <tr>
            <g:sortableColumn property="title" title="Titel"/>
            <g:sortableColumn property="dateCreated" title="Datum"/>
          </tr>
          </thead>
          <tbody>

          <g:each status="i" in="${articleList}" var="article">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
              <td><g:link controller="articlePost" action="show" id="${article.id}">${article.title}</g:link></td>
              <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${article.dateCreated}"/></td>
            </tr>
          </g:each>

          </tbody>
        </table>
      </g:else>

      <g:if test="${articleCount > 0}">
        <div class="paginateButtons">
          <g:paginate action="showArticleList" total="${articleCount}" params="[name:entity.name]"/>
        </div>
      </g:if>

    </div>
  </div>
</div>
</body>

