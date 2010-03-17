<head>
  <title>Lernardo | Aktivitätsvorlage</title>
  <meta name="layout" content="private"/>
  <g:javascript library="jquery"/>
</head>

<body>
<div class="headerBlue">
  <div class="second">
    <h1>Aktivitätsvorlage</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <table class="listing">
      <tr class="prop"><td class="name" style="width: 200px">Name:</td><td class="value">${template.profile.fullName}</td></tr>
      <tr class="prop"><td class="name">Primäre Zuordnung:</td><td class="value">${template.profile.attribution}</td></tr>
      <tr class="prop"><td class="name">Beschreibung:</td><td class="value">${template.profile.description.decodeHTML()}</td></tr>
      <tr class="prop"><td class="name">Ressourcen:</td><td class="value"><app:getResources entity="${template}">
        <ul>
          <g:each in="${resources}" var="resource">
            <li><g:link controller="resourceProfile" action="show" id="${resource.id}">${resource.profile.fullName}</g:link></li>
          </g:each>
        </ul>
      </app:getResources></td></tr>
      <tr class="prop"><td class="name">Dauer:</td><td class="value">${template.profile.duration} Minuten</td></tr>
      <tr class="prop"><td class="name">Sozialform:</td><td class="value">${template.profile.socialForm}</td></tr>
      <tr class="prop"><td class="name">Teamgröße:</td><td class="value">${template.profile.requiredEducators}</td></tr>
      <tr class="prop"><td class="name">Qualifikationen:</td><td class="value">${template.profile.qualifications}</td></tr>
      <tr class="prop"><td class="name">Lernen lernen:</td><td class="value">
        <% template.profile.ll.toInteger().times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.ll.toInteger()).times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star_empty.png')}" alt="star"/><% } %>
      </td></tr>
      <tr class="prop"><td class="name">Bewegung & Ernährung:</td><td class="value">
        <% template.profile.be.toInteger().times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.be.toInteger()).times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star_empty.png')}" alt="star"/><% } %>
      </td></tr>
      <tr class="prop"><td class="name">Persönliche Kompetenz:</td><td class="value">
        <% template.profile.pk.toInteger().times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.pk.toInteger()).times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star_empty.png')}" alt="star"/><% } %>
      </td></tr>
      <tr class="prop"><td class="name">Soziale & emotionale Intelligenz:</td><td class="value">
        <% template.profile.si.toInteger().times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.si.toInteger()).times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star_empty.png')}" alt="star"/><% } %>
      </td></tr>
      <tr class="prop"><td class="name">Handwerk & Kunst:</td><td class="value">
        <% template.profile.hk.toInteger().times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.hk.toInteger()).times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star_empty.png')}" alt="star"/><% } %>
      </td></tr>
      <tr class="prop"><td class="name">Teilleistungstraining:</td><td class="value">
        <% template.profile.tlt.toInteger().times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star.png')}" alt="star"/><% } %><% (3 - template.profile.tlt.toInteger()).times { %><img src="${g.resource(dir: 'images/icons', file: 'icon_star_empty.png')}" alt="star"/><% } %>
      </td></tr>
    </table>

    <app:isEducator entity="${entity}">
      <g:link class="buttonBlue" action="edit" id="${template.id}">Bearbeiten</g:link>
      <g:link class="buttonGray" action="del" id="${template.id}" onclick="return confirm('Aktivitätsvorlage wirklich löschen?');">Löschen</g:link>
      <g:link class="buttonBlue" controller="activity" action="create" id="${template.id}">Neue Aktivität planen</g:link>
      <div class="spacer"></div>
    </app:isEducator>

  </div>
</div>

<div class="headerBlue">
  <div class="second">
    <h1>Kommentare</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:if test="${!commentList}">
      Keine Kommentare vorhanden
    </g:if>
    <g:else>
      <g:each in="${commentList}" var="comment">
        <div class="single-entry">
          <div class="user-entry"><app:getCreator entity="${comment}">
            <div class="user-pic">
              <g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}" params="[entity:creator.id]">
                <ub:profileImage name="${creator.name}" width="50" height="65" align="left"/>
              </g:link>
            </div>
            <div class="community-entry-infobar">
              <div class="name">von <g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}" params="[entity:creator.id]">${creator.profile.fullName}</g:link></div>
              <div class="info">
                <div class="time"><g:formatDate format="dd. MM. yyyy, HH:mm" date="${comment.profile.dateCreated}"/></div>
                <ub:meOrAdmin entityName="${creator.name}">
                  <div class="actions"><g:link controller="commentTemplate" action="delete" id="${comment.id}" params="[template:template.id]" onclick="return confirm('Kommentar wirklich löschen?');">löschen</g:link></div>
                </ub:meOrAdmin>
              </div>
            </div>
            <div class="spacer"></div>
            <div class="entry-content">${comment.profile.content.decodeHTML()}</div>
          </app:getCreator>
          </div>
        </div>
      </g:each>
    </g:else>

    <app:isEducator entity="${entity}">
      <div class="comments-actions">
        <g:remoteLink class="buttonBlue" controller="commentTemplate" action="create" update="createComment" id="${template.id}" after="jQuery('#createComment').show('fast')">Kommentar abgeben</g:remoteLink>
        <div class="spacer"></div>
      </div>
      <div id="createComment">
      </div>
    </app:isEducator>

  </div>
</div>
</body>