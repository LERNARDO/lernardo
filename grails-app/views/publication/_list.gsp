<div class="boxContent">

    <h4><g:message code="publications"/></h4>

    <g:if test="${!publications}">
      <div class="info-msg">
        <g:message code="publication.profile.empty"/>
      </div>
    </g:if>

    <erp:accessCheck types="['Pädagoge']" me="${entity}" creatorof="${entity}">
      <div class="buttons cleared">
      <g:formRemote name="formRemote" url="[controller: 'publication', action: 'create', id: entity.id]" update="content" before="showspinner('#content');">
          <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code: 'publication.upload')}"/></div>
        </g:formRemote>
      </div>
    </erp:accessCheck>

    %{--render own documents--}%

    <g:if test="${publications}">
      <g:render template="pubtype" model="[currentEntity: currentEntity, publist: publications]"/>
    </g:if>

    %{--render other documents--}%
    <g:if test="${activitytemplatesdocuments}">
      <h4><g:message code="fromActivityTemplates"/></h4>
      <g:render template="other" model="[entity: entity, publist: activitytemplatesdocuments]"/>
    </g:if>
    
</div>
