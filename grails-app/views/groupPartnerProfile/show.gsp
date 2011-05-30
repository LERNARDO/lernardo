<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupPartner"/> - ${group.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupPartner"/> - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>
      <table>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="groupPartner.profile.name"/>:</td>
          <td valign="top" class="name-show"><g:message code="groupPartner.profile.description"/>:</td>
        </tr>

        <tr class="prop">
          <td width="200" valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
          <td width="500" valign="top" class="value-show-block">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show">&nbsp;</td>
          <td valign="top" class="name-show"><g:message code="groupPartner.profile.service"/>:</td>
        </tr>
        
        <tr class="prop">
          <td valign="top" class="name-show">&nbsp;</td>
          <td valign="top" class="value-show">${group.profile.service}</td>
        </tr>

      </table>
    </div>

    <div class="buttons">
      <g:form id="${group.id}">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: group.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="partners"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#partners'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="partners" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupPartnerProfile', action:'addPartner', id:group.id]" update="partners2" before="showspinner('#partners2')">
          <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="partners2">
        <g:render template="partners" model="[partners: partners, group: group, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>
</body>