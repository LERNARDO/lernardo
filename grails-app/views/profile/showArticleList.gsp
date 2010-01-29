<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Profil von ${entity.profile.fullName}</title>
  <g:javascript library="jquery"/>
</head>
<body>
<div class="headerBlue">
  <h1>Meine Artikel</h1>
</div>
<div class="boxGray">
<div id="body-list">

  <g:if test="${!articleList}">
    <p>Du hast bis jetzt keine Artikel verfasst</p>
  </g:if>
  <g:else>
    <p>Du hast insgesamt ${articleCount} Artikel verfasst</p>
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

  <div class="paginateButtons">
    <g:paginate action="showArticleList" total="${articleCount}" params="[name:entity.name]"/>
  </div>

</div>
</div>
</body>

