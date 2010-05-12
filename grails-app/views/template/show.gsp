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
      <tr class="prop"><td class="name" style="width: 200px"><g:message code="activityTemplate.name"/>:</td><td class="value">${template.profile.fullName}</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.description"/>:</td><td class="value">${template.profile.description.decodeHTML()}</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.chosenMaterials"/>:</td><td class="value">${template.profile.chosenMaterials.decodeHTML()}</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.duration"/>:</td><td class="value">${template.profile.duration} Minuten</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.socialForm"/>:</td><td class="value">${template.profile.socialForm}</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.amountEducators"/>:</td><td class="value">${template.profile.amountEducators}</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.status"/>:</td><td class="value">${template.profile.status}</td></tr>
    </table>

    <app:isEducator entity="${entity}">
      <g:link class="buttonBlue" action="edit" id="${template.id}"><g:message code="edit"/></g:link>
      <g:link class="buttonGray" action="del" id="${template.id}" onclick="return confirm('Aktivitätsvorlage wirklich löschen?');">Löschen</g:link>
      %{--<g:link class="buttonBlue" controller="activity" action="create" id="${template.id}">Neue Aktivität planen</g:link>--}%
      <div class="spacer"></div>
    </app:isEducator>

    <div>
      <h1>Planbare Ressourcen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-resources"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ressourcen hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        hideform = function(){
          $('#resources').hide('slow') ;
        }
        <jq:toggle sourceId="show-resources" targetId="resources"/>
      </jq:jquery>
      <div id="resources" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'template', action:'addResource', id:template.id]" update="resources2" before="hideform()">
          <g:select name="resource" from="${allResources}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="resources2">
        <g:render template="resources" model="[resources: resources, entity: entity, template: template]"/>
      </div>
    </div>

    <div>
      <h1>Gewichtungsmethode <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-methods"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Gewichtungsmethode hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        hideform2 = function(){
          $('#methods').hide('slow') ;
        }
        <jq:toggle sourceId="show-methods" targetId="methods"/>
      </jq:jquery>
      <div id="methods" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'template', action:'addMethod', id:template.id]" update="methods2" before="hideform2()">
          <g:select name="method" from="${allMethods}" optionKey="id" optionValue="name"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="methods2">
        <g:render template="methods" model="[entity: entity, template: template]"/>
      </div>
    </div>

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
                  <div class="actions"><g:link controller="commentTemplate" action="delete" id="${comment.id}" params="[template:template.id]" onclick="return confirm('Kommentar wirklich löschen?');">Löschen</g:link></div>
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