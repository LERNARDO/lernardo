<table>
  <tr>
    <td>
      <div style="width: 130px;" onmouseover="$('#mypic').css('opacity', '1');" onmouseout="$('#mypic').css('opacity', '0');">
        <erp:profileImage entity="${entity}" width="130"/>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
          <div id="mypic"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></div>
        </erp:accessCheck>
      </div>
    </td>
    <td style="padding-left: 10px; vertical-align: bottom;">
      <div class="buttons" style="margin-bottom: 0;">
        <g:form id="${user.id}" params="[entity: user.id]">
          <erp:accessCheck entity="${currentEntity}" me="${user}">
            <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          </erp:accessCheck>
          <erp:isSystemAdmin entity="${currentEntity}">
            <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: user.id)}" /></div>
          </erp:isSystemAdmin>
          <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
          <erp:getFavorite entity="${user}"/>
          <erp:notMe entity="${entity}">
            <g:if test="${entity.user.enabled}">
              <g:link class="buttonGreen" controller="msg" action="create" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.msgCreate"/></g:link>
            </g:if>
          </erp:notMe>
        </g:form>
        <div class="spacer"></div>
      </div>
    </td>
  </tr>
</table>