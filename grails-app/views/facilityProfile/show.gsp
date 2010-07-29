<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${facility.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${facility.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>
        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="facility.profile.name"/>:
          </td>
          <td colspan="3" valign="top" class="name-show">
            <g:message code="facility.profile.description"/>:
          </td>
        </tr>

        <tr class="prop">
          <td width="290" valign="top" class="value-show"><g:link action="show" id="${facility.id}" params="[entity:facility.id]">${facility.profile.fullName}</g:link></td>
          <td colspan="3" valign="top" class="value-show-block">${fieldValue(bean: facility, field: 'profile.description').decodeHTML() ?: '<div class="italic">leer</div>'}</td>
        </tr>
        <tr class="prop">
        <td colspan="4" valign="top" class="name-show">
        Colonia:
        </td>
          </tr>
        <tr>
        <td  valign="top" class="value-show">
        <g:if test="${colony}"><g:link controller="groupColonyProfile" action="show" id="${colony.id}">${colony.profile.fullName}</g:link></g:if><g:else><span class="italic">Keiner Colonia zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span></g:else>
        </td>
        <td colspan="3" valign="top" >
        </td>
        </tr>

        <tr class="prop">
          <td valign="bottom" class="name-show">
            <g:message code="facility.profile.street"/>:
          </td>
          <td valign="bottom" class="name-show">
            <g:message code="facility.profile.zip"/>:
          </td>
          <td valign="bottom" class="name-show">
            <g:message code="facility.profile.city"/>:
          </td>
          <td valign="bottom" class="name-show">
            <g:message code="facility.profile.country"/>:
          </td>
        </tr>
        <tr class="prop">
          <td width="290" valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.street') ?: '<div class="italic">leeer</div>'}</td>
          <td width="101" valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.zip') ?: '<div class="italic">leer</div>'}</td>
          <td width="220" valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.city') ?: '<div class="italic">leer</div>'}</td>
          <td width="210" align="top" class="value-show">${fieldValue(bean: facility, field: 'profile.country') ?: '<div class="italic">leer</div>'}</td>
        </tr>
      </table>

      <div class="email">
       <table>
          <tr class="prop">
            <app:isAdmin>
            <td width="60" valign="top">
              <g:message code="active"/>:
            </td>
            <td width="50" valign="top" ><g:formatBoolean boolean="${facility.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            </app:isAdmin>
            <td width="60" valign="top" >
              <g:message code="facility.profile.email"/>:
            </td>
            <td valign="top" >${fieldValue(bean: facility, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          </tr>
        </table>
      </div> <!-- div email close -->


    </div>

    <app:isMeOrAdmin entity="${facility}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${facility?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div class="zusatz" >
      <h5>Leitender Pädagoge <g:if test="${!leadeducator}"><app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#leadeducator'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Pädagogen hinzufügen" /></a></app:hasRoleOrType></g:if></h5>
      <div class="zusatz-add" id="leadeducator" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'facilityProfile', action:'addLeadEducator', id: facility.id]" update="leadeducator2" before="showspinner('#leadeducator2')">
          <g:select name="leadeducator" from="${allEducators}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="Hinzufügen"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="leadeducator2">
        <g:render template="leadeducator" model="${leadeducator}"/>
      </div>
    </div>

    <div class="zusatz" >
      <h5>Pädagogen <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#educators'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Pädagogen hinzufügen" /></a></app:hasRoleOrType></h5>
      <div class="zusatz-add" id="educators" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'facilityProfile', action:'addEducator', id: facility.id]" update="educators2" before="showspinner('#educators2')">
          <g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="Hinzufügen"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="educators2">
        <g:render template="educators" model="${educators}"/>
      </div>
    </div>

    <div class="zusatz" >
      <h5>Betreute <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#clients'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Betreute hinzufügen" /></a></app:hasRoleOrType></h5>
      <div class="zusatz-add" id="clients" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'facilityProfile', action:'addClients', id: facility.id]" update="clients2" before="showspinner('#clients2')">
          <g:select name="clientgroup" from="${allClientGroups}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="Hinzufügen"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="${clients}"/>
      </div>
    </div>

    <div class="zusatz" >
      <h5>Ansprechpersonen <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#contacts'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ansprechperson hinzufügen" /></a></app:hasRoleOrType></h5>
      <div class="zusatz-add" id="contacts" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'facilityProfile', action:'addContact', id:facility.id]" update="contacts2" before="showspinner('#contacts2')">

          <table>
            <tr>
              <td>Vorname: </td>
              <td><g:textField name="firstName" size="30"/></td>
            </tr>
            <tr>
              <td>Nachname: </td>
              <td><g:textField name="lastName" size="30"/></td>
            </tr>
            <tr>
              <td>Land: </td>
              <td><g:textField name="country" size="30"/></td>
            </tr>
            <tr>
              <td>PLZ: </td>
              <td><g:textField name="zip" size="30"/></td>
            </tr>
            <tr>
              <td>Stadt: </td>
              <td><g:textField name="city" size="30"/></td>
            </tr>
            <tr>
              <td>Straße: </td>
              <td><g:textField name="street" size="30"/></td>
            </tr>
            <tr>
              <td>Telefon: </td>
              <td><g:textField name="phone" size="30"/></td>
            </tr>
            <tr>
              <td>E-Mail: </td>
              <td><g:textField name="email" size="30"/></td>
            </tr>
            <tr>
              <td>Funktion: </td>
              <td><g:textField name="function" size="30"/></td>
            </tr>
          </table>

          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="contacts2">
        <g:render template="contacts" model="${facility}"/>
      </div>
    </div>

    <div class="zusatz" >
      <h5>Planbare Ressourcen <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#resources'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ressourcen hinzufügen" /></a></app:hasRoleOrType></h5>
      <div class="zusatz-add" id="resources" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'facilityProfile', action:'addResource', id: facility.id]" update="resources2" before="showspinner('#resources2')">
          <table>
            <tr>
              <td><g:message code="resource.profile.name"/>: </td>
              <td><g:textField size="30" name="fullName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.description"/>: </td>
              <td><g:textArea rows="5" cols="50" name="description" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.classification"/>: </td>
              <td><g:select name="classification" from="${['Diese Ressource ist nur für diese Einrichtung verfügbar.','Diese Ressource ist für alle Einrichtungen in dieser Colonia verfügbar.','Diese Ressource steht für alle Einrichtungen im Betrieb zur Verfügung.']}" value="" /></td>
            </tr>
          </table>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show"  id="resources2">
        <g:render template="resources" model="[resources: resources, facility: facility]"/>
      </div>
    </div>

  </div>
</div>
</body>
