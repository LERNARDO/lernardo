<table>
  <tr>
    <td style="width: 135px">
      <erp:profileImage entity="${entity}" width="130"/>
    </td>

    <td valign="top">
      <ul>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
          <li class="icon-person"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></li>
        </erp:accessCheck>

        <li class="profile-profil"><g:link controller="educatorProfile" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="profile"/></g:link></li>
        <li class="icon-document"><g:link controller="publication" action="list" id="${entity.id}"><g:message code="privat.docs"/></g:link> <erp:getPublicationCount entity="${entity}"/></li>

        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
          <li class="icon-news"><g:link controller="profile" action="news" id="${entity.id}"><g:message code="privat.events"/></g:link></li>
        </erp:accessCheck>

        <erp:accessCheck entity="${currentEntity}" me="${entity}">
          <li class="profile-nachricht"><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="privat.posts"/></g:link> <erp:getNewInboxMessages entity="${entity}"/></li>
          <li class="profile-activities"><g:link controller="profile" action="showArticleList" id="${entity.id}"><g:message code="privat.articleList"/></g:link></li>
        </erp:accessCheck>

        <erp:notMe entity="${entity}">
          <g:if test="${entity.user.enabled}">
            <li class="profile-nachricht"><g:link controller="msg" action="create" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.msgCreate"/></g:link></li>
          </g:if>
        </erp:notMe>

        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
          <li class="icon-evaluation"><g:link controller="evaluation" action="myevaluations" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.evaluation"/></g:link></li>
          <li class="icon-time"><g:link controller="workdayUnit" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.workday"/></g:link></li>
        </erp:accessCheck>

        <li class="icon-appointments"><g:link controller="appointmentProfile" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="appointments"/></g:link></li>

      </ul>
    </td>
  </tr>
</table>