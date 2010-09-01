<div id="comments">
<g:if test="${!commented.profile.comments}">
  Keine Kommentare vorhanden
</g:if>
<g:else>
  <g:each in="${commented.profile.comments}" var="comment">

    <div class="comment">
      <app:getCreator id="${comment.creator}">
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
              <app:isMeOrAdminOrOperator entity="${currentEntity}">
                <div class="actions">
                  <g:remoteLink controller="comment" action="delete" update="comments" id="${commented.id}" params="[comment: comment.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Kommentar entfernen" align="top"/></g:remoteLink>
                </div>
              </app:isMeOrAdminOrOperator>
              <div class="infobar">
                <span class="gray">von <span class="name"><g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}" params="[entity:creator.id]">${creator.profile.fullName}</g:link></span>
                am <g:formatDate format="dd. MM. yyyy, HH:mm" date="${comment.dateCreated}"/></span>
              </div>
              <div class="content">${comment.content.decodeHTML()}</div>
            </td>
            </tr>
          </table>
      </app:getCreator>
    </div>

  </g:each>
</g:else>
</div>
