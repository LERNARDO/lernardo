<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Artikel</title>
</head>
<body>
<g:if test="${entity.profile.showTips}">
  <div class="toolTip">
    <div class="second">
      <b><img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/>Tipp:</b> Diese Seite bietet einen Überblick über sämtliche von dir verfasste Artikel.
    </div>
  </div>
</g:if>
<div class="headerBlue">
  <div class="second">
    <h1>Artikel</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div id="body-list">

      <g:if test="${!articleList}">
        Du hast bis jetzt keine Artikel verfasst.
      </g:if>
      <g:else>
        <p>Du hast insgesamt ${articleCount} Artikel verfasst.</p>
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

