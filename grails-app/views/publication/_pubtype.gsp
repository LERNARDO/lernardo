<div id="body-list">
<table>
<tr>
  <th class="title"><g:message code="publication.profile.name"/>%{--${type.name}--}%</th>
  %{-- TODO: uncomment when implemented --}%
  %{--<ub:meOrAdmin entityName="${entity}"><th class="title"><g:message code="publication.type.visibility"/></th></ub:meOrAdmin>--}%
  %{--<th><g:message code="publication.type"/></th>--}%
  <th class="date"><g:message code="publication.type.date"/></th>
  <ub:meOrAdmin entityName="${entity.name}">
    <th class="action"><g:message code="publication.type.function"/></th>
  </ub:meOrAdmin>
</tr>

<g:each var="pub" in="${publist}" status="i">
  <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
    <td class="title"><a target="_blank" href="${createLink(action:'showasset', params:'[name:pub.entity.name]', id:pub.id)}">${pub.name}</a></td>
    %{-- TODO: uncomment when implemented --}%
    %{--<ub:meOrAdmin entityName="${entity}"><td><erp:showAccessLevel accesslevel="${pub.accesslevel}"/></td></ub:meOrAdmin>--}%
    %{--<td><erp:getFileType type="${pub.asset.storage.contentType}"/></td>--}%
    <td><g:formatDate date="${pub.dateCreated}"  format="dd.MM.yyyy"/></td>
    <ub:meOrAdmin entityName="${entity.name}">
      <td class="action"><g:link action="edit" id="${pub.id}"><g:message code="edit"/></g:link> | <g:link action="delete" id="${pub.id}" onclick="return confirm('Sind Sie sicher?');"><g:message code="delete"/></g:link> </td>
    </ub:meOrAdmin>
  </tr>
</g:each>
</table>
</div>
