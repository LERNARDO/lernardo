<%@ page import="at.uenterprise.erp.Setup" %>
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
      <table style="width: 100%">

        <tr>
          <td valign="top" class="name-show"><g:message code="name"/>:</td>
          <td valign="top" class="name-show"><g:message code="description"/>:</td>
        </tr>

        <tr>
          <td valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
          <td valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>
        
      </table>
    </div>

    <div class="buttons">
      <g:form id="${group.id}">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: group.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGreen" action="createpdf" value="${message(code: 'createPDF')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="groupClient.clients.info"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#clients');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="clients" style="display:none">
        <g:message code="clients"/><br/>
        <g:formRemote name="formRemote0" url="[controller:'groupClientProfile', action:'updateselect']" update="clientselect" before="showspinner('#clientselect')">

          <table>
            <tr>
              <td width="180px"><g:message code="name"/>:</td>
              <td><g:textField name="name"/></td>
            </tr>
            <tr>
              <td><g:message code="birthDate"/>:</td>
              <td><g:message code="between"/> <g:datePicker name="birthDate1" precision="year" years="${new Date().getYear()+1800..new Date().getYear()+1900}" noSelection="[null:message(code:'all')]" value="none"/> - <g:datePicker name="birthDate2" precision="year" years="${new Date().getYear()+1800..new Date().getYear()+1901}" noSelection="[null:message(code:'all')]" value="none"/></td>
            </tr>
            <tr>
              <td><g:message code="gender"/>:</td>
              <td><g:select name="gender" from="${['0':message(code:'all'),'1':message(code:'male'),'2':message(code:'female')]}" optionKey="key" optionValue="value"/></td>
            </tr>
            <tr>
              <td><g:message code="groupColony"/>:</td>
              <td><g:select name="colonia" from="${allColonias}" optionKey="id" optionValue="profile" noSelection="['all':message(code:'all')]"/></td>
            </tr>
            <tr>
              <td><g:message code="client.profile.school"/>:</td>
              <td><g:textField name="school"/></td>
            </tr>
            <tr>
              <td><g:message code="client.profile.schoolLevel"/>:</td>
              <td>
                <g:select name="schoolLevel" from="${Setup.list()[0]?.schoolLevels}" noSelection="['all': message(code: 'all')]"/>
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