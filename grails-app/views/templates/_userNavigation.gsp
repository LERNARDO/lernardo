<table>
  <tr>
    <td>
      <div style="width: 160px;" onmouseover="$('#mypic').css('opacity', '1');" onmouseout="$('#mypic').css('opacity', '0');">
        <erp:profileImage entity="${entity}" width="160" height="160"/>
        <erp:accessCheck types="['Betreiber']" me="${entity}">
          <div id="mypic"><g:link controller="profile" action="uploadProfileImage" id="${entity.id}"><g:message code="privat.picture.change"/></g:link></div>
        </erp:accessCheck>
      </div>
    </td>
    <td style="padding-left: 10px; vertical-align: top;">
      <table class="info">
          <tr>
            <td><erp:isSystemAdmin>
              <g:if test="${entity.user.enabled}"><img class="tooltip" data-tooltip="${message(code: 'isActive')}" src="${resource(dir: 'images/icons', file: 'icon_enabled.png')}" alt="aktiv" style="top: 1px; position: relative"/></g:if><g:else><img class="tooltip" data-tooltip="${message(code: 'isInactive')}" src="${resource(dir: 'images/icons', file: 'icon_disabled.png')}" alt="inaktiv"/></g:else> <g:formatBoolean boolean="${entity.user.enabled}" true="${message(code:'active')}" false="${message(code:'inactive')}"/>
            </erp:isSystemAdmin></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><img src="${resource(dir: 'images/icons', file: 'icon_mail.png')}" alt="mail" style="top: 1px; position: relative"/> ${fieldValue(bean: entity, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
      <div class="buttons" style="margin-bottom: 0;">
        <g:form id="${entity.id}">
          <erp:accessCheck me="${entity}">
            <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          </erp:accessCheck>
          <erp:isSystemAdmin>
            <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: entity.id)}" /></div>
          </erp:isSystemAdmin>
          <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
          <erp:getFavorite entity="${entity}"/>
          <erp:notMe entity="${entity}">
            <g:if test="${entity.user.enabled}">
              <g:link class="buttonGreen" controller="msg" action="create" id="${entity.id}"><g:message code="privat.msgCreate"/></g:link>
            </g:if>
          </erp:notMe>
        </g:form>
        <erp:accessCheck types="['Betreiber']" me="${entity}">
          <g:form controller="profile" action="changePassword" id="${entity.id}">
            <g:submitButton class="buttonGreen" name="submit" value="${message(code: 'change.pwd')}"/>
          </g:form>
        </erp:accessCheck>
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