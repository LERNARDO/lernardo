<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupColony"/> - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="groupColony"/> - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
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

    <erp:isOperator entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isOperator>

    <div class="zusatz">
      <h5><g:message code="representantives"/> <erp:isOperator entity="${currentEntity}"><a onclick="toggle('#representatives');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Repräsentant hinzufügen"/>
      </a></erp:isOperator></h5>
      <div class="zusatz-add" id="representatives" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupColonyProfile', action:'addRepresentative', id:group.id]" update="representatives2" before="showspinner('#representatives2')">

          <table>
            <tr>
              <td><g:message code="contact.firstName"/>:</td>
              <td><g:textField size="30" name="firstName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.lastName"/>:</td>
              <td><g:textField size="30" name="lastName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.country"/>:</td>
              <td><g:textField size="30" name="country" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.zip"/>:</td>
              <td><g:textField size="30" name="zip" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.city"/>:</td>
              <td><g:textField size="30" name="city" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.street"/>:</td>
              <td><g:textField size="30" name="street" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.phone"/>:</td>
              <td><g:textField size="30" name="phone" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.email"/>:</td>
              <td><g:textField size="30" name="email" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.function"/>:</td>
              <td><g:textField size="30" name="function" value=""/></td>
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

    %{-- AAZ (01.09.2010): disabled since customer doesn't need it ---}%
    %{--<div class="zusatz">
      <h5><g:message code="building"/> (<g:message code="building.info"/>) <erp:isOperator entity="${currentEntity}"><a onclick="toggle('#buildings');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Gebäude hinzufügen"/></a></erp:isOperator></h5>
      <div class="zusatz-add" id="buildings" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupColonyProfile', action:'addBuilding', id:group.id]" update="buildings2" before="showspinner('#buildings2')">

          <table>
            <tr>
              <td><g:message code="building.name"/>:</td>
              <td><g:textField size="30" name="name" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.zip"/>:</td>
              <td><g:textField size="30" name="zip" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.city"/>:</td>
              <td><g:textField size="30" name="city" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.street"/>:</td>
              <td><g:textField size="30" name="street" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.phone"/>:</td>
              <td><g:textField size="30" name="phone" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.email"/>:</td>
              <td><g:textField size="30" name="email" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.authority"/>:</td>
              <td><g:textField size="30" name="authority" value=""/></td>
            </tr>
          </table>

          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="buildings2">
        <g:render template="buildings" model="[group: group, entity: currentEntity]"/>
      </div>
    </div>--}%

    <div class="zusatz">
      <h5><g:message code="resource.profile"/> <erp:isOperator entity="${currentEntity}"><a onclick="toggle('#resources');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ressourcen hinzufügen"/></a></erp:isOperator></h5>
      <div class="zusatz-add" id="resources" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'groupColonyProfile', action:'addResource', id:group.id]" update="resources2" before="showspinner('#resources2')">
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
        <g:render template="resources" model="[resources: resources, group: group, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="facilities"/> <erp:isOperator entity="${currentEntity}"><a onclick="toggle('#facilities');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Einrichtung hinzufügen"/></a></erp:isOperator></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'groupColonyProfile', action:'addFacility', id: group.id]" update="facilities2" before="showspinner('#facilities2')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, group: group, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="partners"/> <erp:isOperator entity="${currentEntity}"><a onclick="toggle('#partners');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Partner hinzufügen"/></a></erp:isOperator></h5>
      <div class="zusatz-add" id="partners" style="display:none">
        <g:formRemote name="formRemote5" url="[controller:'groupColonyProfile', action:'addPartner', id:group.id]" update="partners2" before="showspinner('#partners2')">
          <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="partners2">
        <g:render template="partners" model="[partners: partners, group: group, entity: currentEntity]"/>
      </div>
    </div>

    %{--<div class="zusatz">
      <h5><g:message code="educators"/> <erp:isOperator entity="${currentEntity}"><a onclick="toggle('#educators');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Pädagogen hinzufügen"/></a></erp:isOperator></h5>
      <div class="zusatz-add" id="educators" style="display:none">
        <g:formRemote name="formRemote6" url="[controller:'groupColonyProfile', action:'addEducator', id:group.id]" update="educators2" before="showspinner('#educators2')">
          <g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="educators2">
        <g:render template="educators" model="[educators: educators, group: group, entity: currentEntity]"/>
      </div>
    </div>--}%

  </div>
</div>
</body>
