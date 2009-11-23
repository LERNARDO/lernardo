<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>${template.name}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />
    <g:javascript library="jquery" />
  </head>

  <body>
    <div id="body-list">
      <div class="profile-group" style="width:200px;">Aktivitätsvorlage - Details</div>
      <div class="profile-box">
        <table width="100%">
          <tr class="separator"><td class="bold titles2 bezeichnung">Name:</td><td class="bezeichnung">${template.name}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Zuordnung:</td><td class="bezeichnung">${template.attribution}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Beschreibung:</td><td class="bezeichnung">${template.description}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Dauer:</td><td class="bezeichnung">${template.duration}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Sozialform:</td><td class="bezeichnung">${template.socialForm}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Materialien:</td><td class="bezeichnung">${template.materials}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Lernen lernen:</td><td class="bezeichnung">
<% template.ll.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Bewegung & Ernährung:</td><td class="bezeichnung">
  <% template.be.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Persönliche Kompetenz:</td><td class="bezeichnung">
    <% template.pk.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Soziale & emotionale Intelligenz:</td><td class="bezeichnung">
      <% template.si.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Handwerk & Kunst:</td><td class="bezeichnung">
        <% template.hk.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Teilleistungstraining:</td><td class="bezeichnung">
          <% template.tlt.toInteger().times { %><img src="${g.resource(dir:'images/icons', file:'icon_star.png')}" alt="star"/><% } %>
            </td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Qualifikationen:</td><td class="bezeichnung">${template.qualifications}</td></tr>
          <tr class="separator"><td class="bold titles2 bezeichnung">Teamgröße:</td><td class="bezeichnung">${template.requiredPaeds}</td></tr>
        </table>
      </div>

      <div id="newActivity">
        <g:link controller="activity" action="create" id="${template.id}">Neue Aktivität planen</g:link>
      </div>
      <div id="newTemplate">
        <g:link controller="template" action="create" id="${template.id}">Neue Aktivitätsvorlage erstellen</g:link>
      </div>

      <div id="comments-block">
        <h1>Kommentare</h1>

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
                    <div class="actions"><g:link controller="post" action="deleteActivityTemplateComment" id="${comment.id}" params="[template:template.id]">löschen</g:link></div>
                  </ub:meOrAdmin>
                </div>
              </div>
              <div class="clear"></div>
              <div class="entry-content">${comment.content}</div>
            </div>
          </div>
          </g:each>
        </g:else>

        %{--
        <div class="single-entry">
          <div class="user-entry">
            <div class="user-pic">
              <g:link action="show" controller="profile" params="[name:'regina']"><img src="${resource(dir:'images/avatar', file:'regina_toncourt.jpg')}" width="50" height="60" align="left" /></g:link>
            </div>
            <div class="community-entry-infobar">
              <div class="name"><g:link action="show" controller="profile" params="[name:'regina']">Regina Toncourt</g:link></div>
              <div class="info">
                <div class="time">am Montag - 28. September 2009 , 16:30h</div>
                <div class="actions"><a href="#">Kommentieren</a></div>
              </div>
            </div>
            <div class="clear"></div>
            <div class="entry-content">
              Sehr nette Aktivität! <br />
              Die Beschreibung könnte aber noch etwas genauer ausgeführt werden.
            </div>
          </div>

          <div class="community-entry-comments">
            <div class="entry">
              <div class="user-pic">
                <g:link action="show" controller="profile" params="[name:'patrizia']"><img src="${resource(dir:'images/avatar', file:'patrizia_rosenkranz.jpg')}" width="50" height="60" /></g:link>
              </div>
              <div class="user-comment">
                <div class="info">
                  <div class="user-name"><g:link action="show" controller="profile" params="[name:'patrizia']">Patrizia Rosenkranz</g:link></div>
                  <div class="time">am Dienstag - 29. September 2009, 16:39h</div>
                </div>
                <div class="comment">
                  Ja schon, finde ich auch!
                </div>
              </div>
              <div class="clear"></div>
            </div>
          </div>

          <div class="community-entry-comments">
            <div class="entry">
              <div class="user-pic">
                <g:link action="show" controller="profile" params="[name:'martin']"><img src="${resource(dir:'images/avatar', file:'martin_golja.jpg')}" width="50" height="60" /></g:link>
              </div>
              <div class="user-comment">
                <div class="info">
                  <div class="user-name"><g:link action="show" controller="profile" params="[name:'martin']">Martin Golja</g:link></div>
                  <div class="time">am Dienstag - 29. September 2009, 17:00h</div>
                </div>
                <div class="comment">
                  So l&auml;sst es aber mehr Platz für individuelle Interpretation. Finde ich nicht schlecht!
                </div>
              </div>
              <div class="clear"></div>
            </div>
          </div>
        </div>
        <!-- END single-entry -->

        <div class="single-entry">
          <div class="user-entry">
            <div class="user-pic">
              <g:link action="show" controller="profile" params="[name:'johannes']"><img src="${resource(dir:'images/avatar', file:'johannes_zeitelberger.jpg')}" width="50" height="60" align="left" /></g:link>
            </div>
            <div class="community-entry-infobar">
              <div class="name"><g:link action="show" controller="profile" params="[name:'johannes']">Johannes Zeitelberger</g:link></div>
              <div class="info">
                <div class="time">am Dienstag - 29. September 2009 , 17:30h</div>
                <div class="actions"><a href="#">Kommentieren</a></div>
              </div>
            </div>
            <div class="clear"></div>
            <div class="entry-content">
              Das Rating mit den Sternen ist sehr n&uuml;tzlich. Da sieht man gleich auf einem Blick die Zuordnung.
            </div>
          </div>
        </div>
        <!-- END single-entry -->

        <div class="single-entry">
          <div class="user-entry">
            <div class="user-pic">
              <g:link action="show" controller="profile" params="[name:'johannes']"><img src="${resource(dir:'images/avatar', file:'johannes_zeitelberger.jpg')}" width="50" height="60" align="left" /></g:link>
            </div>
            <div class="community-entry-infobar">
              <div class="name"><g:link action="show" controller="profile" params="[name:'johannes']">Johannes Zeitelberger</g:link></div>
              <div class="info">
                <div class="time">am Mittwoch - 30. September 2009, 08:30h</div>
                <div class="actions"><g:link action="show" controller="profile" params="[name:'johannes']">Kommentieren</g:link></div>
              </div>
            </div>
            <div class="clear"></div>
            <div class="entry-content">
              Das Kommentarsystem finde ich auch sehr gelungen!
            </div>
          </div>

          <div class="community-entry-comments">
            <div class="entry">
              <div class="user-pic">
                <g:link action="show" controller="profile" params="[name:'alexander']"><img src="${resource(dir:'images/avatar', file:'alexander_zeillinger.jpg')}" width="50" height="60" /></g:link>
              </div>
              <div class="user-comment">
                <div class="info">
                  <div class="user-name"><g:link action="show" controller="profile" params="[name:'alexander']">Alexander Zeillinger</g:link></div>
                  <div class="time">am Mittwoch - 30. September 2009, 08:45h</div>
                </div>
                <div class="comment">
                  Haben ja auch wir gemacht!
                </div>
              </div>
              <div class="clear"></div>
            </div>
          </div>

        </div>
        <!-- END single-entry -->
        --}%

        <div class="comments-actions">
          <g:remoteLink class="button" controller="post" action="createtemplatecomment" update="createComment" id="${template.id}" after="jQuery('#createComment').show('fast')" >Kommentar abgeben</g:remoteLink>
        </div>
        <div id="createComment">
        </div>
      </div>
    </div>
  </body>

</html>