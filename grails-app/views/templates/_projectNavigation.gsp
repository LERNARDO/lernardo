<table>
  <tr>
    <td>
      <div style="width: 160px;" onmouseover="$('#mypic').css('opacity', '1');" onmouseout="$('#mypic').css('opacity', '0');">
        <erp:profileImage entity="${entity}" width="160" height="160"/>
        <erp:accessCheck types="['Betreiber']" creatorof="${entity}">
          <div id="mypic"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></div>
        </erp:accessCheck>
      </div>
    </td>
    <td style="padding-left: 10px; vertical-align: bottom;">
      <div class="buttons" style="margin-bottom: 0;">
        <g:form id="${entity.id}">
          <erp:accessCheck types="['Betreiber']" facilities="${facilities}" creatorof="${entity}">
            <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
            <div class="button"><g:actionSubmit class="buttonGreen" action="shift" value="${message(code: 'shift')}" /></div>
              <g:if test="${!entity.profile.completed}">
                <div class="button"><g:actionSubmit class="buttonGreen" action="complete" value="${message(code: 'project.complete')}" /></div>
              </g:if>
            <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: entity.id)}" /></div>
          </erp:accessCheck>
          <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
        </g:form>
        <div class="clear"></div>
      </div>
    </td>
  </tr>
</table>