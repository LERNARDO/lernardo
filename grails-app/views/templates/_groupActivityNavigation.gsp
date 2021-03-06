<table>
  <tr>
    <td>
      <div style="width: 160px;" onmouseover="$('#mypic').css('opacity', '1');" onmouseout="$('#mypic').css('opacity', '0');">
        <erp:profileImage entity="${entity}" width="160" height="160"/>
        <erp:accessCheck types="['Betreiber']" creatorof="${entity}">
          <div id="mypic"><g:remoteLink update="content" controller="profile" action="uploadProfileImage" id="${entity.id}" before="showspinner('#content');"><g:message code="privat.picture.change"/></g:remoteLink></div>
        </erp:accessCheck>
      </div>
    </td>
    <td style="padding-left: 10px; vertical-align: bottom;">
      <div class="buttons cleared" style="margin-bottom: 0;">
        <g:form id="${entity.id}">
          <erp:accessCheck types="['Betreiber']" creatorof="${entity}">
            <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
            <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: entity.id)}" /></div>
          </erp:accessCheck>
          <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
          <div class="button">
            <a class="buttonGreen" href="#" onclick="jQuery('#modal').modal(); return false"><g:message code="createPDF"/></a>
          </div>
        </g:form>
      </div>
    </td>
  </tr>
</table>

<div id="modal" style="display: none;">
  <g:form controller="groupActivityProfile" action="createpdf" id="${entity.id}">
    <p><g:message code="selectPageFormat"/></p>
    <g:render template="/templates/printRadioGroup"/>
    <p>
      <g:checkBox name="printtemplates" value=""/> <g:message code="activityTemplates.with"/>
    </p>
    <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
  </g:form>
</div>