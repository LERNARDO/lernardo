<div style="margin-top: 10px">
<table class="default-table">
<tr>
  <th class="title"><g:message code="publication.profile.name"/>%{--${type.name}--}%</th>
  %{-- TODO: uncomment when implemented --}%
  %{--<ub:meOrAdmin entityName="${entity}"><th class="title"><g:message code="publication.type.visibility"/></th></ub:meOrAdmin>--}%
  %{--<th><g:message code="publication.type"/></th>--}%
  <th><g:message code="belongsTo"/></th>
  <th class="date"><g:message code="publication.type.date"/></th>
</tr>

<g:each var="pub" in="${publist}" status="i">
  <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
    <td class="title"><a target="_blank" href="${createLink(action:'showasset', params:'[name:pub.entity.name]', id:pub.id)}">${pub.name}</a></td>
    %{-- TODO: uncomment when implemented --}%
    %{--<ub:meOrAdmin entityName="${entity}"><td><erp:showAccessLevel accesslevel="${pub.accesslevel}"/></td></ub:meOrAdmin>--}%
    %{--<td><erp:getFileType type="${pub.asset.storage.contentType}"/></td>--}%
    <td><g:link controller="${pub.entity.type.supertype.name + 'Profile'}" action="show" id="${pub.entity.id}">${pub.entity.profile.fullName}</g:link></td>
    <td><g:formatDate date="${pub.dateCreated}"  format="dd.MM.yyyy"/></td>
  </tr>
</g:each>
</table>
</div>
