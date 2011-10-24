<table>
  <tr>
    <td style="width: 135px">
      <erp:profileImage entity="${entity}" width="130"/>
    </td>

    <td valign="top">
      <ul>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${entity}">
          <li class="icon-person"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></li>
        </erp:accessCheck>

        <li class="profile-profil"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="profile"/></g:link></li>
        <li class="icon-document"><g:link controller="publication" action="list" id="${entity.id}"><g:message code="publications"/></g:link> <erp:getPublicationCount entity="${entity}"/></li>

        <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
          <li class="icon-admin"><g:link controller="groupActivityProfile" action="listevaluations" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.evaluation"/></g:link></li>
        </erp:accessCheck>

      </ul>
    </td>
  </tr>
</table>