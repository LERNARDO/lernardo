<head>
  <meta name="layout" content="private"/>
  <title><g:message code="publication.docs"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="publication.docs"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:if test="${!publications}">
      <div class="info-msg">
        <g:message code="publication.profile.empty"/>
      </div>
    </g:if>

    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']">
      <div class="action-buttons">
        <g:link class="buttonGreen" controller="publication" id="${entity.id}" action="create"><img src="${g.resource (dir:'images/icons', file:'icon_document.png')}" alt="icon" align="top"/> <g:message code="publication.profile.create"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:accessCheck>

    %{--render own documents--}%

    <g:if test="${publications}">
      <g:render template="pubtype" model="[entity: entity, publist: publications]"/>
    </g:if>

    %{--render other documents--}%
    <g:if test="${activitytemplatesdocuments}">
      <h1><g:message code="fromActivityTemplates"/></h1>
      <g:render template="other" model="[entity: entity, publist: activitytemplatesdocuments]"/>
    </g:if>

    <g:if test="${groupactivitytemplatesdocuments}">
      <h1><g:message code="fromGroupActivityTemplates"/></h1>
      <g:render template="other" model="[entity: entity, publist: groupactivitytemplatesdocuments]"/>
    </g:if>

    <g:if test="${projecttemplatedocuments}">
      <h1><g:message code="fromProjectTemplate"/></h1>
      <g:render template="other" model="[entity: entity, publist: projecttemplatedocuments]"/>
    </g:if>
    
  </div>

</div>
</body>
