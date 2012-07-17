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
          <erp:accessCheck types="['Betreiber']" creatorof="${entity}">
            <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
            <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: entity.id)}" /></div>
          </erp:accessCheck>
          <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
          <erp:getFavorite entity="${entity}"/>
        </g:form>
        <div class="clear"></div>
      </div>
        <div id="favmodal" style="display: none;">
            <p><g:message code="favorite.selectFolder"/></p>
            <g:formRemote name="formRemote" url="[controller: 'profile', action: 'addFavorite', id: entity.id.toString()]" update="favbutton" before="jQuery('#favmodalinfo').show();">
                <erp:getFolders>
                    <g:select name="folder" from="${folders}" optionKey="id" optionValue="name"/>
                    <g:submitButton name="button" value="${message(code: 'favorite.add')}"/>
                </erp:getFolders>
            </g:formRemote>
            <div id="favmodalinfo" style="display: none;"><p class="green"><g:message code="favorite.created"/></p></div>
        </div>
    </td>
  </tr>
</table>
