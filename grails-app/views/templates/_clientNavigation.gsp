<div style="margin-bottom: 10px; font-size: 14px;"><erp:getFavorite entity="${entity}"/> ${entity.profile}<br/><span style="font-size: 12px;">(<g:message code="client"/>)</span></div>

<div style="width: 160px;" onmouseover="$('#mypic').css('opacity', '1');" onmouseout="$('#mypic').css('opacity', '0');">
    <erp:profileImage entity="${entity}" width="160" height="160"/>
    <erp:accessCheck types="['Betreiber']" me="${entity}">
        <div id="mypic"><g:remoteLink update="content" controller="profile" action="uploadProfileImage" id="${entity.id}" before="showspinner('#content');"><g:message code="privat.picture.change"/></g:remoteLink></div>
    </erp:accessCheck>
</div>

<div id="left" class="profile-box">
    <ul>
        <erp:isSystemAdmin>
            <g:if test="${entity.user.enabled}">
                <li class="icon-enabled"><span style="margin-left: 10px; color: #666;"><g:message code="isActive"/></span></li>
            </g:if>
            <g:else>
                <li class="icon-disabled"><span style="margin-left: 10px; color: #666;"><g:message code="isInactive"/></span></li>
            </g:else>
        </erp:isSystemAdmin>
        <li class="icon-mail"><span style="margin-left: 10px; color: #666;"><erp:truncate string="${entity.user.email}" length="18"/></span></li>
        <g:form id="${entity?.id}">
            <erp:accessCheck types="['Betreiber']" me="${entity}" facilities="${facilities}">
                <li class="icon-edit"><g:actionSubmit style="border: none; background: none; cursor: pointer;" action="edit" value="${message(code: 'edit')}" /></li>
            </erp:accessCheck>
            <erp:accessCheck types="['Betreiber']">
                <li class="icon-delete"><g:actionSubmit style="border: none; background: none; cursor: pointer;" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: entity.id)}" /></li>
            </erp:accessCheck>
            <erp:notMe entity="${entity}">
                <g:if test="${entity.user.enabled}">
                    <li class="icon-network"><g:remoteLink update="content" controller="msg" action="create" id="${entity.id}"><g:message code="privat.msgCreate"/></g:remoteLink></li>
                </g:if>
            </erp:notMe>
        </g:form>
        <erp:accessCheck types="['Betreiber']" me="${entity}">
            <g:form controller="profile" action="changePassword" id="${entity.id}">
                <li class="icon-key"><g:submitButton name="submit" style="border: none; background: none; cursor: pointer;" value="${message(code: 'change.pwd')}"/></li>
            </g:form>
        </erp:accessCheck>
    </ul>
</div>

%{--<table>
  <tr>
    <td>
      <div style="width: 160px;" onmouseover="$('#mypic').css('opacity', '1');" onmouseout="$('#mypic').css('opacity', '0');">
        <erp:profileImage entity="${entity}" width="160" height="160"/>
        <erp:accessCheck types="['Betreiber']" me="${entity}">
          <div id="mypic"><g:remoteLink update="content" controller="profile" action="uploadProfileImage" id="${entity.id}" before="showspinner('#content');"><g:message code="privat.picture.change"/></g:remoteLink></div>
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
      <div class="buttons cleared" style="margin-bottom: 0;">
        <g:form id="${entity?.id}">
          <erp:accessCheck types="['Betreiber']" me="${entity}" facilities="${facilities}">
            <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          </erp:accessCheck>
          <erp:accessCheck types="['Betreiber']">
            <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: entity.id)}" /></div>
          </erp:accessCheck>
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
      </div>
    </td>
  </tr>
</table>--}%

