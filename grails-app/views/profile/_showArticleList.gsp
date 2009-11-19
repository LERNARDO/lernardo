<h2>Liste aller Artikel</h2>
<p>${articleList.size()} Artikel gefunden</p>

<table>
  <thead>
  <tr>
    <g:sortableColumn property="title" title="Titel"/>
    <g:sortableColumn property="dateCreated" title="Datum"/>
    <th>Kommentare</th>
  </tr>
  </thead>
  <tbody>
  <g:each status="i" in="${articleList}" var="article">
    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
      <td><g:link action="show" id="${article.id}">${article.title}</g:link></td>
      <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${article.dateCreated}"/></td>
      <td><app:getCommentsCountPost post="${article}"/></td>
    </tr>
  </g:each>
  </tbody>
</table>

<div class="paginateButtons">
  <g:paginate action="list" total="${articleList.size()}"/>
</div>