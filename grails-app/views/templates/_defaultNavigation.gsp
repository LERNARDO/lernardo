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

        <li class="profile-profil"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="privat.profile"/></g:link></li>
        <li class="icon-document"><g:link controller="publication" action="profile" id="${entity.id}"><g:message code="privat.docs"/></g:link> <erp:getPublicationCount entity="${entity}"/></li>

      </ul>
    </td>
  </tr>
</table>