  <head>
    <title>Lernardo | Aktivitätsvorlage</title>
    <meta name="layout" content="private" />
    <g:javascript library="jquery" />
  </head>

  <body>
    <div class="headerBlue">
      <h1>Aktivitätsvorlage</h1>
    </div>
    <div class="boxGray">
        <table width="100%">
          <tr class="separator"><td class="bold titles2 bezeichnung">Name:</td><td class="bezeichnung">${template.profile.fullName}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Primäre Zuordnung:</td><td class="bezeichnung">${template.profile.attribution}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Beschreibung:</td><td class="bezeichnung">${template.profile.description.decodeHTML()}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Ressourcen:</td><td class="bezeichnung"><app:getResources entity="${template}">
            <ul>
              <g:each in="${resources}" var="resource">
                <li><g:link controller="resourceProfile" action="show" id="${resource.id}">${resource.profile.fullName}</g:link></li>
              </g:each>
            </ul>
          </app:getResources></td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Dauer:</td><td class="bezeichnung">${template.profile.duration} Minuten</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Sozialform:</td><td class="bezeichnung">${template.profile.socialForm}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Teamgröße:</td><td class="bezeichnung">${template.profile.requiredPaeds}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Qualifikationen:</td><td class="bezeichnung">${template.profile.qualifications}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Lernen lernen:</td><td class="bezeichnung">
<% template.profile.ll.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.ll.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Bewegung & Ernährung:</td><td class="bezeichnung">
  <% template.profile.be.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.be.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Persönliche Kompetenz:</td><td class="bezeichnung">
    <% template.profile.pk.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.pk.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Soziale & emotionale Intelligenz:</td><td class="bezeichnung">
      <% template.profile.si.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.si.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Handwerk & Kunst:</td><td class="bezeichnung">
        <% template.profile.hk.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.hk.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Teilleistungstraining:</td><td class="bezeichnung">
          <% template.profile.tlt.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.tlt.toInteger()).times { %><img src="${g.resource(dir:'images/icons', file:'icon_star_empty.png')}" alt="star"/><% } %>
            </td></tr>
        </table>

      <app:isPaed entity="${entity}">
          <g:link class="buttonBlue" action="edit" id="${template.id}">Aktivitätsvorlage bearbeiten</g:link>
          <g:link class="buttonBlue" action="del" id="${template.id}" onclick="return confirm('Aktivitätsvorlage wirklich löschen?');">Aktivitätsvorlage löschen</g:link>
          <g:link class="buttonBlue" controller="activity" action="create" id="${template.id}">Neue Aktivität planen</g:link>
          <div class="spacer"></div>
      </app:isPaed>


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
            <div class="user-entry"><app:getCreator entity="${comment}">
              <div class="user-pic">
                <g:link controller="profile" action="show" params="[name:creator.name]">
                  <ub:profileImage name="${creator.name}" width="50" height="65" align="left"/>
                </g:link>
              </div>
              <div class="community-entry-infobar">
                <div class="name"><g:link action="show" controller="profile" params="[name:creator.name]">${creator.profile.fullName}</g:link></div>
                <div class="info">
                  <div class="time"><g:formatDate format="dd. MMM. yyyy, HH:mm" date="${comment.profile.dateCreated}"/></div>
                  <ub:meOrAdmin entityName="${creator.name}">
                    <div class="actions"><g:link controller="commentTemplate" action="delete" id="${comment.id}" params="[template:template.id]">löschen</g:link></div>
                  </ub:meOrAdmin>
                </div>
              </div>
              <div class="clear"></div>
              <div class="entry-content">${comment.profile.content.decodeHTML()}</div>
            </app:getCreator>
            </div>
          </div>
          </g:each>
        </g:else>

        <app:isPaed entity="${entity}">
          <div class="comments-actions">
            <g:remoteLink class="buttonBlue" controller="commentTemplate" action="create" update="createComment" id="${template.id}" after="jQuery('#createComment').show('fast')" >Kommentar abgeben</g:remoteLink>
            <div class="spacer"></div>
          </div>
          <div id="createComment">
          </div>
        </app:isPaed>

      </div>
  </body>