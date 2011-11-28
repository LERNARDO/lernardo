<table>
  <tr>
    <td>
      <div style="width: 130px;" onmouseover="$('#mypic').css('opacity', '1');" onmouseout="$('#mypic').css('opacity', '0');">
        <erp:profileImage entity="${entity}" width="130"/>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${entity}">
          <div id="mypic"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></div>
        </erp:accessCheck>
      </div>
    </td>
    <td style="padding-left: 10px; vertical-align: bottom;">
      <div class="buttons" style="margin-bottom: 0;">
        <g:form id="${group.id}" params="[entity: group?.id]">
          <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']" creatorof="${group}" checkstatus="${group}" checkoperator="true">
            <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          </erp:accessCheck>
          <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}">
            <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: group.id)}" /></div>
          </erp:accessCheck>
          <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
            <g:if test="${group.profile.status == 'done'}">
              <g:link class="buttonGreen" controller="groupActivityProfile" action="create" id="${group.id}"><g:message code="groupActivity.plan"/></g:link>
            </g:if>
            <div class="button"><g:actionSubmit class="buttonGreen" action="copy" value="${message(code: 'groupActivityTemplate.duplicate')}" /></div>
          </erp:accessCheck>
          <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
          <erp:getFavorite entity="${group}"/>
        </g:form>
        <div class="spacer"></div>
      </div>
    </td>
  </tr>
</table>
