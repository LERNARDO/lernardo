  <head>
    <title>${template.name}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <g:javascript library="jquery" />
  </head>

  <body>
    <div class="headerBlue">
      <h1>Aktivitätsvorlage</h1>
    </div>
    <div class="boxGray">
      <div class="profile-box">
        <table width="100%">
          <tr class="separator"><td class="bold titles2 bezeichnung">Name:</td><td class="bezeichnung">${template.name}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Zuordnung:</td><td class="bezeichnung">${template.attribution}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Beschreibung:</td><td class="bezeichnung">${template.description.decodeHTML()}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Materialien:</td><td class="bezeichnung">${template.materials}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Dauer:</td><td class="bezeichnung">${template.duration} Minuten</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Sozialform:</td><td class="bezeichnung">${template.socialForm}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Teamgröße:</td><td class="bezeichnung">${template.requiredPaeds}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Qualifikationen:</td><td class="bezeichnung">${template.qualifications}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Lernen lernen:</td><td class="bezeichnung">
<% template.ll.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.ll.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>            
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Bewegung & Ernährung:</td><td class="bezeichnung">
  <% template.be.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.be.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Persönliche Kompetenz:</td><td class="bezeichnung">
    <% template.pk.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.pk.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Soziale & emotionale Intelligenz:</td><td class="bezeichnung">
      <% template.si.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.si.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Handwerk & Kunst:</td><td class="bezeichnung">
        <% template.hk.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.hk.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Teilleistungstraining:</td><td class="bezeichnung">
          <% template.tlt.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.tlt.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
        </table>
      </div>

      <g:if test="${entity.type.name == 'Paed'}">
          <g:link class="buttonBlue" action="edit" id="${template.id}">Aktivitätsvorlage bearbeiten</g:link>
          <g:link class="buttonBlue" action="del" id="${template.id}" onclick="return confirm('Aktivitätsvorlage wirklich löschen?');">Aktivitätsvorlage löschen</g:link>
          <g:link class="buttonBlue" controller="activity" action="create" id="${template.id}">Neue Aktivität planen</g:link>
          <div class="spacer"></div>
      </g:if>


    </div>

  <div class="headerBlue">
      <h1>Kommentare</h1>
    </div>
  <div class="boxGray">

        <g:if test="${!commentList}">
          Keine Kommentare vorhanden
        </g:if>
        <g:else>
          <g:each in="${commentList}" var="comment">
          <div class="single-entry">
            <div class="user-entry">
              <div class="user-pic">
                <g:link controller="profile" action="show" params="[name:comment.author.name]">
                  <ub:profileImage name="${comment.author.name}" width="50" height="65" align="left"/>
                </g:link>
              </div>
              <div class="community-entry-infobar">
                <div class="name"><g:link action="show" controller="profile" params="[name:comment.author.name]">${comment.author.profile.fullName}</g:link></div>
                <div class="info">
                  <div class="time"><g:formatDate format="dd. MMM. yyyy, HH:mm" date="${comment.dateCreated}"/></div>
                  <ub:meOrAdmin entityName="${comment.author.name}">
                    <div class="actions"><g:link controller="templateComment" action="delete" id="${comment.id}" params="[template:template.id]">löschen</g:link></div>
                  </ub:meOrAdmin>
                </div>
              </div>
              <div class="clear"></div>
              <div class="entry-content">${comment.content.decodeHTML()}</div>
            </div>
          </div>
          </g:each>
        </g:else>

        <g:if test="${entity.type.name == 'Paed'}">
          <div class="comments-actions">
            <g:remoteLink class="buttonBlue" controller="templateComment" action="create" update="createComment" id="${template.id}" after="jQuery('#createComment').show('fast')" >Kommentar abgeben</g:remoteLink>
            <div class="spacer"></div>
          </div>
          <div id="createComment">
          </div>
        </g:if>

      </div>
  </body>