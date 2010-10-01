<head>
  <meta name="layout" content="private"/>
  <title><g:message code="publication.docs"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="publication.docs"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']">
      <div class="action-buttons">
        <g:link class="buttonGreen" controller="publication" id="${entity.id}" action="create"><img src="${g.resource (dir:'images/icons', file:'icon_document.png')}" alt="icon" align="top"/> <g:message code="publication.profile.create"/></g:link>
        <div class="spacer" style="margin-bottom: 10px"></div>
      </div>
    </app:hasRoleOrType>

    %{--render own documents--}%
    <g:if test="${!publications}">
      <div class="info-msg">
        <g:message code="publication.profile.empty"/>
      </div>
    </g:if>

    <g:render template="pubtype" model="[entity: entity, publist: publications]"/>

    %{--render other documents--}%
    <g:if test="${activitytemplatesdocuments}">
      <h1>Aus Aktivitätsvorlagen</h1>

      <g:render template="other" model="[entity: entity, publist: activitytemplatesdocuments]"/>
    </g:if>

    <g:if test="${groupactivitytemplatesdocuments}">
      <h1>Aus Aktivitätsblockvorlagen</h1>

      <g:render template="other" model="[entity: entity, publist: groupactivitytemplatesdocuments]"/>
    </g:if>

    <g:if test="${projecttemplatedocuments}">
      <h1>Aus Projektvorlage</h1>

      <g:render template="other" model="[entity: entity, publist: projecttemplatedocuments]"/>
    </g:if>
    
  </div>

</div>
</body>
