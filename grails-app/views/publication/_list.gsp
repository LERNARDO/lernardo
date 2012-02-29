<div class="boxGray">
  <div class="second">

    <h4><g:message code="publications"/></h4>

    <g:if test="${!publications}">
      <div class="info-msg">
        <g:message code="publication.profile.empty"/>
      </div>
    </g:if>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}" creatorof="${entity}">
      <div class="buttons">
      <g:formRemote name="formRemote" url="[controller:'publication', action:'create', id: entity.id]" update="content" before="showspinner('#content');">
          <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code: 'publication.upload')}"/></div>
          <div class="clear"></div>
        </g:formRemote>
      </div>
    </erp:accessCheck>

    %{--render own documents--}%

    <g:if test="${publications}">
      <g:render template="pubtype" model="[entity: entity, publist: publications, currentEntity: currentEntity]"/>
    </g:if>

    %{--render other documents--}%
    <g:if test="${activitytemplatesdocuments}">
      <h4><g:message code="fromActivityTemplates"/></h4>
      <g:render template="other" model="[entity: entity, publist: activitytemplatesdocuments]"/>
    </g:if>

    <g:if test="${groupactivitytemplatesdocuments}">
      <h4><g:message code="fromGroupActivityTemplates"/></h4>
      <g:render template="other" model="[entity: entity, publist: groupactivitytemplatesdocuments]"/>
    </g:if>

    <g:if test="${projecttemplatedocuments}">
      <h4><g:message code="fromProjectTemplate"/></h4>
      <g:render template="other" model="[entity: entity, publist: projecttemplatedocuments]"/>
    </g:if>
    
  </div>

</div>
