<table>
  <tr>
    <td style="width: 130px" onmouseover="$('#mypic').css('opacity','1');" onmouseout="$('#mypic').css('opacity','0');">
      <erp:profileImage entity="${entity}" width="130"/>
      <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
        <div id="mypic"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></div>
      </erp:accessCheck>
    </td>

    <td valign="top">
      <ul>
        %{--<erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
          <li class="icon-person"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></li>
        </erp:accessCheck>--}%

        <li class="profile-profil"><g:link controller="userProfile" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="profile"/></g:link></li>
        <li class="icon-document"><g:link controller="publication" action="list" id="${entity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${entity}"/></g:link></li>

        %{--<erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
          <li class="icon-news"><g:link controller="event" action="index" id="${entity.id}"><g:message code="events"/></g:link></li>
        </erp:accessCheck>--}%

        <erp:accessCheck entity="${currentEntity}" me="${entity}">
          <li class="profile-nachricht"><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="privat.posts"/></g:link></li>
        </erp:accessCheck>

        <erp:notMe entity="${entity}">
          <g:if test="${entity.user.enabled}">
            <li class="profile-nachricht"><g:link controller="msg" action="create" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.msgCreate"/></g:link></li>
          </g:if>
        </erp:notMe>

        <li class="icon-appointments"><g:link controller="appointmentProfile" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="appointments"/></g:link></li>

      </ul>
    </td>
  </tr>
</table>