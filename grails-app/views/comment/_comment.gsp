<erp:getCreator id="${comment.creator}">
  <g:if test="${creator}">
    <table>
      <tr>
        <td style="vertical-align: top">
          <div class="userpic">
            <g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}" params="[entity:creator.id]">
              <erp:profileImage entity="${creator}" width="50" height="65" align="left"/>
            </g:link>
          </div>
        </td>
        <td style="width: 100%; vertical-align: top">
          <div class="infobar">
            <span class="gray">
              <span class="name"><g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}" params="[entity:creator.id]">${creator.profile.fullName}</g:link></span>
              <g:message code="atDate"/> <g:formatDate format="dd. MM. yyyy, HH:mm" date="${comment.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
              <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${creator}">
                  <g:remoteLink controller="comment" action="edit" update="content${i}" id="${commented.id}" params="[comment: comment.id, i: i]"><img src="${g.resource(dir:'images/icons', file:'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink>
                  <g:remoteLink controller="comment" action="delete" update="comments" id="${commented.id}" params="[comment: comment.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
              </erp:accessCheck>
            </span>
          </div>
          <div class="content" id="content${i}">${comment.content.decodeHTML()}</div>
        </td>
      </tr>
    </table>
  </g:if>
</erp:getCreator>