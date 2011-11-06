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

        <li class="profile-profil"><g:link controller="facilityProfile" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="profile"/></g:link></li>
        <li class="icon-document"><g:link controller="publication" action="list" id="${entity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${entity}"/></g:link></li>
        <li class="icon-admin"><g:link controller="dayroutine" action="list" id="${entity.id}" params="[entity:entity.id]"><g:message code="dayroutine"/></g:link></li>

      </ul>
    </td>
  </tr>
</table>