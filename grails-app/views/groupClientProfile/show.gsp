<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupClient"/> - ${group.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupClient"/> - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>
      <table>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="groupClient.profile.name"/>:</td>
          <td valign="top" class="name-show"><g:message code="groupClient.profile.description"/>:</td>
        </tr>

        <tr class="prop">
          <td width="200" valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
          <td width="500" valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>
        
      </table>
    </div>

    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonRed" action="del" id="${group.id}" onclick="${erp.getLinks(id: group.id)}"><g:message code="delete"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:accessCheck>

    <div class="zusatz">
      <h5><g:message code="groupClient.clients.info"/> <erp:isOperator entity="${currentEntity}"><a onclick="toggle('#clients');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Betreute hinzufügen"/></a></erp:isOperator></h5>
      <div class="zusatz-add" id="clients" style="display:none">
        <g:message code="clients"/><br/>
        <g:formRemote name="formRemote0" url="[controller:'groupClientProfile', action:'updateselect']" update="clientselect" before="showspinner('#clientselect')">

          <table>
            <tr>
              <td width="180px"><g:message code="client.profile.name"/>:</td>
              <td><g:textField name="name"/></td>
            </tr>
            <tr>
              <td><g:message code="client.profile.birthDate"/>:</td>
              <td><g:message code="between"/> <g:datePicker name="birthDate1" precision="year" years="${new Date().getYear()+1800..new Date().getYear()+1900}" noSelection="[null:message(code:'all')]" value="none"/> - <g:datePicker name="birthDate2" precision="year" years="${new Date().getYear()+1800..new Date().getYear()+1901}" noSelection="[null:message(code:'all')]" value="none"/></td>
            </tr>
            <tr>
              <td><g:message code="client.profile.gender"/>:</td>
              <td><g:select name="gender" from="${['0':message(code:'all'),'1':message(code:'male'),'2':message(code:'female')]}" optionKey="key" optionValue="value"/></td>
            </tr>
            <tr>
              <td><g:message code="groupColony"/>:</td>
              <td><g:select name="colonia" from="${allColonias}" optionKey="id" optionValue="profile" noSelection="['all':message(code:'all')]"/></td>
            </tr>
            <tr>
              <td><g:message code="client.profile.schoolLevel"/>:</td>
              <td>
                <g:select name="schoolLevel" from="${grailsApplication.config.schoollevels}" noSelection="['all': message(code: 'all')]" valueMessagePrefix="schoollevel"/>
              </td>
            </tr>
            <g:if test="${grailsApplication.config.clientProfile.job}">
            <tr>
              <td><g:message code="client.profile.job"/>:</td>
              <td><g:select name="job" from="${['0':message(code:'all'),'1':message(code:'yes'),'2':message(code:'no')]}" optionKey="key" optionValue="value"/></td>
            </tr>
            </g:if>
          </table>
          <g:submitButton name="button" value="${message(code:'groupClient.clients.define')}"/>
          <div class="spacer"></div>
        </g:formRemote>

        <g:formRemote name="formRemote" url="[controller:'groupClientProfile', action:'addClient', id:group.id]" update="clients2" before="showspinner('#clients2')">
          <div id="clientselect">
            <g:render template="searchresults" model="[allClients: allClients]"/>
          </div>
        </g:formRemote>

      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, group: group, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>
</body>