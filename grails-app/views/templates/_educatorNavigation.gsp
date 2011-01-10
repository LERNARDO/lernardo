<table>
  <tr>
    <td style="width: 135px">
      <ub:profileImage name="${entity.name}" width="130"/>
    </td>

    <td>
      <ul>
        <erp:isMeOrAdminOrOperator entity="${entity}" current="${currentEntity}">
          <li class="icon-person"><g:link controller="profile" action="uploadprf" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></li>
        </erp:isMeOrAdminOrOperator>

        <li class="profile-profil"><g:link controller="educatorProfile" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="privat.profile"/></g:link></li>
        <li class="icon-document"><g:link controller="publication" action="profile" id="${entity.id}"><g:message code="privat.docs"/></g:link> <erp:getPublicationCount entity="${entity}"/></li>
        <li class="icon-news"><g:link controller="profile" action="showNews" id="${entity.id}"><g:message code="privat.events"/></g:link></li>

        <erp:isMeOrAdmin entity="${currentEntity}">
          <li class="profile-nachricht"><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="privat.posts"/></g:link> <erp:getNewInboxMessages entity="${entity}"/></li>
          <li class="profile-activities"><g:link controller="profile" action="showArticleList" id="${entity.id}"><g:message code="privat.articleList"/></g:link></li>
        </erp:isMeOrAdmin>

        <erp:notMe entity="${entity}">
          <g:if test="${entity.user.enabled}">
            <li class="profile-nachricht"><g:link controller="msg" action="create" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.msgCreate"/></g:link></li>
          </g:if>
        </erp:notMe>

        <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']">
          <li class="icon-evaluation"><g:link controller="evaluation" action="myevaluations" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.evaluation"/></g:link></li>
          <li class="icon-admin"><g:link controller="workdayUnit" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.workday"/></g:link></li>
        </erp:accessCheck>

        <li class="icon-admin"><g:link controller="appointmentProfile" action="index" id="${entity.id}" params="[entity:entity.id]">Termine</g:link></li>

      </ul>
    </td>
  </tr>
</table>