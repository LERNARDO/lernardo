<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupColony"/> - ${group.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupColony"/> - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="groupColony.profile.name"/>:</td>
          <td valign="top" class="name-show"><g:message code="groupColony.profile.description"/>:</td>
        </tr>

        <tr class="prop">
          <td width="200px" valign="top" class="value-show"><g:link controller="${group.type.supertype.name+'Profile'}" action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td width="500px" valign="top" class="value-show-block">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        </tbody>
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
      <h5><g:message code="representantives"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="clearElements(['#cFirstName','#cLastName','#cCountry','#cZip','#cCity','#cStreet','#cPhone','#cEmail','#cFunction']); toggle('#representatives');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/>
      </a></erp:accessCheck></h5>
      <div class="zusatz-add" id="representatives" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupColonyProfile', action:'addRepresentative', id:group.id]" update="representatives2" before="showspinner('#representatives2');" after="toggle('#representatives');">

          <table>
            <tr>
              <td><g:message code="contact.firstName"/>:</td>
              <td><g:textField id="cFirstName" size="30" name="firstName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.lastName"/>:</td>
              <td><g:textField id="cLastName" size="30" name="lastName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.country"/>:</td>
              <td><g:textField id="cCountry" size="30" name="country" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.zip"/>:</td>
              <td><g:textField id="cZip" size="30" name="zip" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.city"/>:</td>
              <td><g:textField id="cCity" size="30" name="city" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.street"/>:</td>
              <td><g:textField id="cStreet" size="30" name="street" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.phone"/>:</td>
              <td><g:textField id="cPhone" size="30" name="phone" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.email"/>:</td>
              <td><g:textField id="cEmail" size="30" name="email" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.function"/>:</td>
              <td><g:textField id="cFunction" size="30" name="function" value=""/></td>
            </tr>
          </table>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="representatives2">
        <g:render template="representatives" model="[group: group, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="resource.profile"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="resources" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'groupColonyProfile', action:'addResource', id:group.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
          <table>
            <tr>
              <td><g:message code="resource.profile.name"/>:</td>
              <td><g:textField id="resourceName" size="30" name="fullName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.description"/>:</td>
              <td><g:textArea id="resourceDescription" rows="5" cols="50" name="description" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.classification"/>:</td>
              <td>
                <g:select name="classification" from="${grailsApplication.config.resourceclasses}" value="" valueMessagePrefix="resourceclass"/>
              </td>
            </tr>
          </table>

          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[resources: resources, group: group, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="facilities"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#facilities');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'groupColonyProfile', action:'addFacility', id: group.id]" update="facilities2" before="showspinner('#facilities2');" after="toggle('#facilities');">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, group: group, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="partners"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#partners');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="partners" style="display:none">
        <g:formRemote name="formRemote5" url="[controller:'groupColonyProfile', action:'addPartner', id:group.id]" update="partners2" before="showspinner('#partners2');" after="toggle('#partners');">
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
