<table>
  <tr>
    <td style="width: 135px">
      <erp:profileImage entity="${entity}" width="130"/>
    </td>

    <td valign="top">
      <ul>
        <erp:isMeOrAdminOrOperator entity="${entity}" current="${currentEntity}">
          <li class="icon-person"><g:link controller="profile" action="uploadprf" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></li>
        </erp:isMeOrAdminOrOperator>

        <li class="profile-profil"><g:link controller="facilityProfile" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="privat.profile"/></g:link></li>
        <li class="icon-document"><g:link controller="publication" action="list" id="${entity.id}"><g:message code="privat.docs"/></g:link> <erp:getPublicationCount entity="${entity}"/></li>
        <li class="icon-admin"><g:link controller="dayroutine" action="list" id="${entity.id}" params="[entity:entity.id]"><g:message code="dayroutine"/></g:link></li>

        %{--<li class="icon-admin"><g:link controller="appointmentProfile" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="appointments"/></g:link></li>--}%

      </ul>
    </td>
  </tr>
</table>