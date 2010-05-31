<head>
  <title>Aktivitätsvorlage</title>
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
      <tr class="prop"><td class="name"><g:message code="activityTemplate.description"/>:</td><td class="value">${template.profile.description.decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.chosenMaterials"/>:</td><td class="value">${template.profile.chosenMaterials.decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.duration"/>:</td><td class="value">${template.profile.duration} Minuten</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.socialForm"/>:</td><td class="value">${template.profile.socialForm}</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.amountEducators"/>:</td><td class="value">${template.profile.amountEducators}</td></tr>
      <tr class="prop"><td class="name"><g:message code="activityTemplate.status"/>:</td><td class="value">${template.profile.status}</td></tr>
    </table>

    <app:isEducator entity="${entity}">
      <g:link class="buttonBlue" action="edit" id="${template.id}"><g:message code="edit"/></g:link>
      <g:link class="buttonGray" action="del" id="${template.id}" onclick="return confirm('Aktivitätsvorlage wirklich löschen?');">Löschen</g:link>
      <g:if test="${template.profile.status == 'fertig'}">
        <g:link class="buttonBlue" controller="activity" action="create" id="${template.id}">Themenraumaktivitäten planen</g:link>
      </g:if>
      <div class="spacer"></div>
    </app:isEducator>

    <div>
      <h5>Planbare Ressourcen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-resources"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ressourcen hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-resources" targetId="resources"/>
      </jq:jquery>
      <div id="resources" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'templateProfile', action:'addResource', id:template.id]" update="resources2" before="hideform('#resources')">
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
      <h5>Gewichtungsmethode <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-methods"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Gewichtungsmethode hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-methods" targetId="methods"/>
      </jq:jquery>
      <div id="methods" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'templateProfile', action:'addMethod', id:template.id]" update="methods2" before="hideform('#methods')">
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

<g:render template="/comment/box" model="[entity: entity, commented: template]"/>

</body>