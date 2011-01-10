<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="facility"/> - ${facility.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="facility"/> - ${facility.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="facility.profile.name"/>:</td>
          <td colspan="3" valign="top" class="name-show"><g:message code="facility.profile.description"/>:</td>
        </tr>

        <tr class="prop">
          <td width="290" valign="top" class="value-show"><g:link action="show" id="${facility.id}" params="[entity:facility.id]">${facility.profile.fullName}</g:link></td>
          <td colspan="3" valign="top" class="value-show-block">${fieldValue(bean: facility, field: 'profile.description').decodeHTML() ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
        </tr>

        <tr class="prop">
          <td colspan="4" valign="top" class="name-show"><g:message code="facility.profile.colony"/>:</td>
        </tr>

        <tr>
          <td valign="top" class="value-show">
            <g:if test="${colony}"><g:link controller="groupColonyProfile" action="show" id="${colony.id}">${colony.profile.fullName}</g:link></g:if><g:else><span class="italic red"><g:message code="facility.profile.noCol"/> %{--<img src="${g.resource(dir: 'images/icons', file: 'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span></g:else>
          </td>
          <td colspan="3" valign="top"></td>
        </tr>

        <tr class="prop">
          <td valign="bottom" class="name-show"><g:message code="facility.profile.street"/>:</td>
          <td valign="bottom" class="name-show"><g:message code="facility.profile.zip"/>:</td>
          <td valign="bottom" class="name-show"><g:message code="facility.profile.city"/>:</td>
          <td valign="bottom" class="name-show"><g:message code="facility.profile.country"/>:</td>
        </tr>

        <tr class="prop">
          <td width="290" valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.street') ?: '<div class="italic">leeer</div>'}</td>
          <td width="101" valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.zip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
          <td width="220" valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.city') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
          <td width="210" align="top" class="value-show">${fieldValue(bean: facility, field: 'profile.country') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
        </tr>

      </table>

      <div class="email">
        <table>
          <tr class="prop">
            %{--<erp:isOperator entity="${currentEntity}">
              <td width="60" valign="top"><g:message code="active"/>:</td>
              <td width="50" valign="top"><g:formatBoolean boolean="${facility.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            </erp:isOperator>--}%
            <td width="60" valign="top"><g:message code="facility.profile.email"/>:</td>
            <td valign="top">${fieldValue(bean: facility, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>
        </table>
      </div>

    </div>

    <div class="buttons">
      <erp:isMeOrAdminOrOperator entity="${facility}" current="${currentEntity}">
        <g:link class="buttonGreen" action="edit" id="${facility?.id}"><g:message code="edit"/></g:link>
      </erp:isMeOrAdminOrOperator>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="leadEducators"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#leadeducators');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Leitenden Pädagogen hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="leadeducators" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteLeadEducators" action="remoteLeadEducators" id="${facility.id}" before="showspinner('#remoteLeadEducators')"/>
        <div id="remoteLeadEducators"></div>

        %{--<g:formRemote name="formRemote" url="[controller:'facilityProfile', action:'addLeadEducator', id: facility.id]" update="leadeducators2" before="showspinner('#leadeducators2')">
          <g:select name="leadeducator" from="${allEducators}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>--}%
      </div>
      <div class="zusatz-show" id="leadeducators2">
        <g:render template="leadeducators" model="[leadeducators: leadeducators, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="educators"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#educators');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Pädagogen hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="educators" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteEducators" action="remoteEducators" id="${facility.id}" before="showspinner('#remoteEducators')"/>
        <div id="remoteEducators"></div>

        %{--<g:formRemote name="formRemote" url="[controller:'facilityProfile', action:'addEducator', id: facility.id]" update="educators2" before="showspinner('#educators2')">
          <g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>--}%
      </div>
      <div class="zusatz-show" id="educators2">
        <g:render template="educators" model="[educators: educators, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="clients"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#clients');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Betreute hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="clients" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${facility.id}" before="showspinner('#remoteClients')"/>
        <div id="remoteClients"></div>

        %{--<g:formRemote name="formRemote2" url="[controller:'facilityProfile', action:'addClients', id: facility.id]" update="clients2" before="showspinner('#clients2')">
          <g:select name="clientgroup" from="${allClientGroups}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>--}%
      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="contacts"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#contacts');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ansprechperson hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="contacts" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'facilityProfile', action:'addContact', id:facility.id]" update="contacts2" before="showspinner('#contacts2')">

          <table>
            <tr>
              <td><g:message code="contact.firstName"/>:</td>
              <td><g:textField name="firstName" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="contact.lastName"/>:</td>
              <td><g:textField name="lastName" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="contact.country"/>:</td>
              <td><g:textField name="country" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="contact.zip"/>:</td>
              <td><g:textField name="zip" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="contact.city"/>:</td>
              <td><g:textField name="city" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="contact.street"/>:</td>
              <td><g:textField name="street" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="contact.phone"/>:</td>
              <td><g:textField name="phone" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="contact.email"/>:</td>
              <td><g:textField name="email" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="contact.function"/>:</td>
              <td><g:textField name="function" size="30"/></td>
            </tr>
          </table>

          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="contacts2">
        <g:render template="contacts" model="[facility: facility, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="resource.profile"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#resources');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ressourcen hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="resources" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'facilityProfile', action:'addResource', id: facility.id]" update="resources2" before="showspinner('#resources2')">
          <table>
            <tr>
              <td><g:message code="resource.profile.name"/>:</td>
              <td><g:textField size="30" name="fullName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.description"/>:</td>
              <td><g:textArea rows="5" cols="50" name="description" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.classification"/>:</td>
              <td>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                  <g:select name="classification" from="${grailsApplication.config.resourceclasses_es}" optionKey="key" optionValue="value" value=""/>
                </g:if>
                <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                  <g:select name="classification" from="${grailsApplication.config.resourceclasses_de}" optionKey="key" optionValue="value" value=""/>
                </g:if>
              </td>
            </tr>
          </table>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[resources: resources, facility: facility, entity: currentEntity]"/>
      </div>
    </div>

    <g:render template="/templates/links" model="[entity: facility]"/>

  </div>
</div>
</body>
