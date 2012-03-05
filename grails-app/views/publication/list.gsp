<head>
  <meta name="layout" content="database"/>
  <title>${entity.profile.fullName.decodeHTML()}: <g:message code="publications"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1>${entity.profile.fullName.decodeHTML()}: <g:message code="publications"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:if test="${!publications}">
      <div class="info-msg">
        <g:message code="publication.profile.empty"/>
      </div>
    </g:if>

    <erp:accessCheck types="['Betreiber']" me="${entity}" creatorof="${entity}">
      <div class="buttons">
        <g:form id="${entity.id}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'publication.upload')}"/></div>
          <div class="clear"></div>
        </g:form>
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
