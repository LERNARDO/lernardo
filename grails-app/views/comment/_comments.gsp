<div id="comments">
<g:if test="${!commented.profile.comments}">
  Keine Kommentare vorhanden
</g:if>
<g:else>
  <g:each in="${commented.profile.comments}" var="comment">
    <div class="single-entry">
      <div class="user-entry"><app:getCreator id="${comment.creator}">
        <div class="user-pic">
          <g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}" params="[entity:creator.id]">
            <ub:profileImage name="${creator.name}" width="50" height="65" align="left"/>
          </g:link>
        </div>
        <div class="community-entry-infobar">
          <div class="name">von <g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}" params="[entity:creator.id]">${creator.profile.fullName}</g:link></div>
          <div class="info">
            <div class="time"><g:formatDate format="dd. MM. yyyy, HH:mm" date="${comment.dateCreated}"/></div>
            <ub:meOrAdmin entityName="${creator.name}">
              <div class="actions">
                %{--<g:link controller="comment" action="delete" id="${template.id}" params="[comment:comment.id]" onclick="return confirm('Kommentar wirklich löschen?');">Löschen</g:link>--}%
                <g:remoteLink controller="comment" action="delete" update="comments" id="${commented.id}" params="[comment: comment.id]">Löschen <img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Kommentar entfernen" align="top"/></g:remoteLink>
              </div>
            </ub:meOrAdmin>
          </div>
        </div>
        <div class="spacer"></div>
        <div class="entry-content">${comment.content.decodeHTML()}</div>
      </app:getCreator>
      </div>
    </div>
  </g:each>
</g:else>
</div>
