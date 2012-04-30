<g:if test="${comments}">
  <p class="italic"><g:message code="comment.size.found" args="[comments.size()]"/></p>
  <g:each in="${comments}" var="comment">
    <div class="comment">
      <erp:getCreator id="${comment.key.creator}">
          <g:if test="${creator}">
            <table>
              <tr>
                <td style="vertical-align: top">
                  <div class="userpic">
                    <g:link controller="${creator.type.supertype.name + 'Profile'}" action="show" id="${creator.id}">
                      <erp:profileImage entity="${creator}" width="50" height="65" align="left"/>
                    </g:link>
                  </div>
                </td>
                <td style="width: 100%; vertical-align: top">
                  %{--<erp:accessCheck types="['Betreiber']" me="${creator}">
                    <div class="actions">
                      <g:remoteLink controller="comment" action="edit" update="comment${i}" id="${commented.id}" params="[comment: comment.id, i: i]"><img src="${g.resource(dir:'images/icons', file:'icon_edit.png')}" alt="${message(code:'edit')}" align="top"/></g:remoteLink>
                      <g:remoteLink controller="comment" action="delete" update="comments" id="${commented.id}" params="[comment: comment.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code:'delete')}" align="top"/></g:remoteLink>
                    </div>
                  </erp:accessCheck>--}%
                  <div class="infobar">
                    <span class="gray"><g:message code="from"/> <span class="name"><g:link controller="${creator.type.supertype.name + 'Profile'}" action="show" id="${creator.id}">${creator.profile.fullName.decodeHTML()}</g:link></span>
                    <g:message code="atDate"/> <g:formatDate format="dd. MM. yyyy, HH:mm" date="${comment.key.dateCreated}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> zu <g:link controller="${comment.value.type.supertype.name + 'Profile'}" action="show" id="${comment.value.id}">${comment.value.profile.fullName.decodeHTML()}</g:link></span>
                  </div>
                  <div class="content">${comment.key.content.decodeHTML()}</div>
                </td>
              </tr>
            </table>
        </g:if>
      </erp:getCreator>
    </div>
    <div class="clear"></div>
  </g:each>
</g:if>
<g:else>
  <span class="italic"><g:message code="comment.size.found" args="[0]"/></span>
</g:else>