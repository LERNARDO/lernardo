<div style="width: 130px; margin-left: 5px;" onmouseover="$('#mypic').css('opacity', '1');" onmouseout="$('#mypic').css('opacity', '0');">
  <erp:profileImage entity="${entity}" width="130"/>
  <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
    <div id="mypic"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></div>
  </erp:accessCheck>
</div>

<ul style="margin-top: 10px;">
  <li class="profile-profil"><g:link controller="facilityProfile" action="show" id="${entity.id}" params="[entity: entity.id]"><g:message code="profile"/></g:link></li>
  <li class="icon-document"><g:link controller="publication" action="list" id="${entity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${entity}"/></g:link></li>
  <li class="icon-admin"><g:link controller="dayroutine" action="list" id="${entity.id}" params="[entity:entity.id]"><g:message code="dayroutine"/></g:link></li>
</ul>