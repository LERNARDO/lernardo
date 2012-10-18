<div>
<table class="default-table">
<tr>
  <th><g:message code="publication.type.visibility"/></th>
  <th class="title"><g:message code="title"/>%{--${type.name}--}%</th>
  %{-- TODO: uncomment when implemented --}%
  %{--<ub:meOrAdmin entityName="${entity}"><th class="title"><g:message code="publication.type.visibility"/></th></ub:meOrAdmin>--}%
  %{--<th><g:message code="publication.type"/></th>--}%
  <th class="date"><g:message code="date"/></th>
  <th><g:message code="creator"/></th>
  <th class="action"><g:message code="publication.type.function"/></th>
</tr>

<g:each var="pub" in="${publist}" status="i">
  <g:if test="${(!pub.isPublic && currentEntity == pub.entity) || pub.isPublic}">
    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
      <td><g:formatBoolean boolean="${pub.isPublic}" true="${message(code: 'public')}" false="${message(code: 'private')}"/></td>
      <td class="title"><a target="_blank" href="${createLink(action: 'showasset', params: '[name: pub.entity.name]', id: pub.id)}">${pub.name}</a></td>
      %{-- TODO: uncomment when implemented --}%
      %{--<ub:meOrAdmin entityName="${entity}"><td><erp:showAccessLevel accesslevel="${pub.accesslevel}"/></td></ub:meOrAdmin>--}%
      %{--<td><erp:getFileType type="${pub.asset.storage.contentType}"/></td>--}%
      <td><g:formatDate date="${pub.dateCreated}"  format="dd.MM.yyyy - HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
      <td><g:if test="${pub.creator}">
          ${pub.creator.profile}
      </g:if>
      <g:else>
          <span class="gray"><g:message code="noData"/></span>
      </g:else></td>
      <td class="action">
        <erp:accessCheck types="['Betreiber']" creatorof="${pub}">
          <g:formRemote name="formRemote" url="[controller: 'publication', action: 'edit', id: pub.id]" update="content" before="showspinner('#content');">
            <div class="buttons" style="margin: 0;">
              <div class="button"><g:submitButton class="buttonGray" name="submitButton" action="edit" value="${message(code: 'edit')}" /></div>
              <div class="button"><g:remoteLink class="buttonGray" update="content" controller="publication" action="delete" method="POST" id="${pub.id}" before="if(!confirm('${message(code:'delete.warn')}')) return false"><g:message code="delete"/></g:remoteLink></div>
            %{--<g:actionSubmit action="delete" value="${message(code: 'delete')}" onclick="return confirm('Sind Sie sicher?');" />--}%
            </div>
          </g:formRemote>
        </erp:accessCheck>
      </td>
    </tr>
  </g:if>
</g:each>
</table>
</div>
