<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${facility.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${facility.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table >
        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="facility.profile.name"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="facility.profile.description"/>:
          </td>
        </tr>

        <tr class="prop">
          <td width="290" valign="top" class="value-show"><g:link action="show" id="${facility.id}" params="[entity:facility.id]">${facility.profile.fullName}</g:link></td>
          <td valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="facility.profile.street"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="facility.profile.zip"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="facility.profile.city"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="facility.profile.country"/>:
          </td>
        </tr>
        <tr class="prop">
          <td width="290" valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          <td width="101" valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.zip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          <td width="220" valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          <td valign="top" class="value-show">${fieldValue(bean: facility, field: 'profile.country') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
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
        <g:link class="buttonBlue" action="edit" id="${facility?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

%{--    <div>
      <h1>Pädagogen <app:isMeOrAdmin entity="${facility}"><a href="#" id="show-educators"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Pädagogen hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-educators" targetId="educators"/>
      </jq:jquery>
      <div id="educators" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'facilityProfile', action:'addEducator']" update="educators2" before="hideform('#educators')">
          <g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="Hinzufügen"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="educators2">
        <g:render template="educators" model="${educators}"/>
      </div>
    </div>

    <div>
      <h1>Betreute <app:isMeOrAdmin entity="${facility}"><a href="#" id="show-clients"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Betreuten hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-clients" targetId="clients"/>
      </jq:jquery>
      <div id="clients" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'facilityProfile', action:'addClient']" update="clients2" before="hideform('#clients')">
          <g:select name="client" from="${allClients}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="Hinzufügen"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="clients2">
        <g:render template="clients" model="${clients}"/>
      </div>
    </div>--}%

    <div>
      <h5>Ansprechpersonen <app:isMeOrAdmin entity="${facility}"><a href="#" id="show-contacts"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ansprechperson hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-contacts" targetId="contacts"/>
      </jq:jquery>
      <div id="contacts" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'facilityProfile', action:'addContact', id:facility.id]" update="contacts2" before="hideform('#contacts')">

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
      <div id="contacts2">
        <g:render template="contacts" model="${facility}"/>
      </div>
    </div>

    <div>
      <h5>Ressourcen <app:isMeOrAdmin entity="${facility}"><a href="#" id="show-resources"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ressourcen hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-resources" targetId="resources"/>
      </jq:jquery>
      <div id="resources" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'facilityProfile', action:'addResource', id: facility.id]" update="resources2" before="hideform('#resources')">
          <g:select name="resource" from="${allResources}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="resources2">
        <g:render template="resources" model="[resources: resources, facility: facility]"/>
      </div>
    </div>

  </div>
</div>
</body>
