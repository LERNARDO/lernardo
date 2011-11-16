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
        %{--<erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${entity}">
          <li class="icon-person"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></li>
        </erp:accessCheck>--}%

        <li class="profile-profil"><g:link controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="profile"/></g:link></li>
        <li class="icon-document"><g:link controller="publication" action="list" id="${entity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${entity}"/></g:link></li>

      </ul>
    </td>
  </tr>
</table>