<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupColony.profile.name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupColony.profile.description"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${group}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h5>Repräsentanten <app:isMeOrAdmin entity="${group}"><a href="#" id="show-representatives"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Repräsentant hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-representatives" targetId="representatives"/>
      </jq:jquery>
      <div id="representatives" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupColonyProfile', action:'addRepresentative', id:group.id]" update="representatives2" before="hideform('#representatives')">

          <table>
            <tr>
              <td><g:message code="contact.firstName"/>: </td>
              <td><g:textField size="30" name="firstName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.lastName"/>: </td>
              <td><g:textField size="30" name="lastName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.country"/>: </td>
              <td><g:textField size="30" name="country" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.zip"/>: </td>
              <td><g:textField size="30" name="zip" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.city"/>: </td>
              <td><g:textField size="30" name="city" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.street"/>: </td>
              <td><g:textField size="30" name="street" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.phone"/>: </td>
              <td><g:textField size="30" name="phone" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.email"/>: </td>
              <td><g:textField size="30" name="email" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="contact.function"/>: </td>
              <td><g:textField size="30" name="function" value=""/></td>
            </tr>
          </table>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="representatives2">
        <g:render template="representatives" model="${group}"/>
      </div>
    </div>

    <div>
      <h5>Gebäude <app:isMeOrAdmin entity="${group}"><a href="#" id="show-buildings"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Gebäude hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-buildings" targetId="buildings"/>
      </jq:jquery>
      <div id="buildings" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupColonyProfile', action:'addBuilding', id:group.id]" update="buildings2" before="hideform('#buildings')">

          <table>
            <tr>
              <td><g:message code="building.name"/>: </td>
              <td><g:textField size="30" name="name" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.zip"/>: </td>
              <td><g:textField size="30" name="zip" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.city"/>: </td>
              <td><g:textField size="30" name="city" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.street"/>: </td>
              <td><g:textField size="30" name="street" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.phone"/>: </td>
              <td><g:textField size="30" name="phone" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.email"/>: </td>
              <td><g:textField size="30" name="email" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="building.authority"/>: </td>
              <td><g:textField size="30" name="authority" value=""/></td>
            </tr>
          </table>

          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="buildings2">
        <g:render template="buildings" model="${group}"/>
      </div>
    </div>

    <div>
      <h5>Einrichtungen <app:isMeOrAdmin entity="${group}"><a href="#" id="show-facilities"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Einrichtung hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-facilities" targetId="facilities"/>
      </jq:jquery>
      <div id="facilities" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'groupColonyProfile', action:'addFacility', id: group.id]" update="facilities2" before="hideform('#facilities')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, group: group]"/>
      </div>
    </div>

    <div>
      <h5>Ressourcen <app:isMeOrAdmin entity="${group}"><a href="#" id="show-resources"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ressourcen hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-resources" targetId="resources"/>
      </jq:jquery>
      <div id="resources" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'groupColonyProfile', action:'addResource', id:group.id]" update="resources2" before="hideform('#resources')">
          <g:select name="resource" from="${allResources}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="resources2">
        <g:render template="resources" model="[resources: resources, group: group]"/>
      </div>
    </div>

  </div>
</div>
</body>
