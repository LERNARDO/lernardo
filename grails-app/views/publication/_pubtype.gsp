<div id="body-list">
<table>
<tr>
  <th class="title">${type.name}</th>
  %{-- TODO: uncomment when implemented --}%
  %{--<ub:meOrAdmin entityName="${entity}"><th class="title">Sichtbarkeit</th></ub:meOrAdmin>--}%
  <th>Dateityp</th>
  <th class="date">Datum</th>
  <ub:meOrAdmin entityName="${entity.name}">
    <th class="action">Funktionen</th>
  </ub:meOrAdmin>
</tr>

<g:each var="pub" in="${publist}" status="i">
  <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
    <td class="title"><a target="_blank" href="${createLink(action:'showasset', params:'[name:pub.entity.name]', id:pub.id)}">${pub.name}</a></td>
    %{-- TODO: uncomment when implemented --}%
    %{--<ub:meOrAdmin entityName="${entity}"><td><app:showAccessLevel accesslevel="${pub.accesslevel}"/></td></ub:meOrAdmin>--}%
    <td><app:getFileType type="${pub.asset.storage.contentType}"/></td>
    <td><g:formatDate date="${pub.dateCreated}"  format="dd.MM.yyyy"/></td>
    <ub:meOrAdmin entityName="${entity.name}">
      <td class="action"> <g:link action="delete" id="${pub.id}">Löschen</g:link> </td>
    </ub:meOrAdmin>
  </tr>
</g:each>
</table>
</div>
