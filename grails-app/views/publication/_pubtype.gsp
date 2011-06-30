<div>
<table class="default-table">
<tr>
  <th class="title"><g:message code="publication.profile.name"/>%{--${type.name}--}%</th>
  %{-- TODO: uncomment when implemented --}%
  %{--<ub:meOrAdmin entityName="${entity}"><th class="title"><g:message code="publication.type.visibility"/></th></ub:meOrAdmin>--}%
  %{--<th><g:message code="publication.type"/></th>--}%
  <th class="date"><g:message code="publication.type.date"/></th>
  <th class="action"><g:message code="publication.type.function"/></th>
</tr>

<g:each var="pub" in="${publist}" status="i">
  <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
    <td class="title"><a target="_blank" href="${createLink(action:'showasset', params:'[name:pub.entity.name]', id:pub.id)}">${pub.name}</a></td>
    %{-- TODO: uncomment when implemented --}%
    %{--<ub:meOrAdmin entityName="${entity}"><td><erp:showAccessLevel accesslevel="${pub.accesslevel}"/></td></ub:meOrAdmin>--}%
    %{--<td><erp:getFileType type="${pub.asset.storage.contentType}"/></td>--}%
    <td><g:formatDate date="${pub.dateCreated}"  format="dd.MM.yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
    <td class="action">
      <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${pub}">
        <g:form id="${pub.id}">
          <g:actionSubmit action="edit" value="${message(code: 'edit')}" />
          <g:actionSubmit action="delete" value="${message(code: 'delete')}" onclick="return confirm('Sind Sie sicher?');" />
        </g:form>
      </erp:accessCheck>
    </td>
  </tr>
</g:each>
</table>
</div>
