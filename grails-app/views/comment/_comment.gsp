<erp:getCreator id="${comment.creator}">
  <table>
    <tr>
      <td style="vertical-align: top">
        <div class="userpic">
          <g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}" params="[entity:creator.id]">
            <ub:profileImage name="${creator.name}" width="50" height="65" align="left"/>
          </g:link>
        </div>
      </td>
      <td style="width: 100%; vertical-align: top">
        <erp:isMeOrAdminOrOperator entity="${creator}" current="${currentEntity}">
          <div class="actions">
            <g:remoteLink controller="comment" action="edit" update="comment${i}" id="${commented.id}" params="[comment: comment.id, i: i]"><img src="${g.resource(dir:'images/icons', file:'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink>
            <g:remoteLink controller="comment" action="delete" update="comments" id="${commented.id}" params="[comment: comment.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
          </div>
        </erp:isMeOrAdminOrOperator>
        <div class="infobar">
          <span class="gray"><g:message code="from"/> <span class="name"><g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}" params="[entity:creator.id]">${creator.profile.fullName}</g:link></span>
          <g:message code="atDate"/> <g:formatDate format="dd. MM. yyyy, HH:mm" date="${comment.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></span>
        </div>
        <div class="content">${comment.content.decodeHTML()}</div>
      </td>
      </tr>
    </table>
</erp:getCreator>