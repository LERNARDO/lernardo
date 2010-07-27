<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="groupColony.profile.name"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="groupColony.profile.description"/>:
          </td>
        </tr>

        <tr class="prop">
          <td width="200px" valign="top" class="value-show"><g:link controller="${group.type.supertype.name+'Profile'}" action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>

          <td width="500px" valign="top" class="value-show-block">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${group}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div class="zusatz">
      <h5><g:message code="representantives"/> <app:isOperator entity="${entity}"><a href="#" id="show-representatives"> <img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Repräsentant hinzufügen" />
     </a></app:isOperator></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-representatives" targetId="representatives"/>
      </jq:jquery>
      <div class="zusatz-add" id="representatives" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupColonyProfile', action:'addRepresentative', id:group.id]" update="representatives2" before="showspinner('#representatives2')">

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
      <div class="zusatz-show" id="representatives2">
        <g:render template="representatives" model="${group}"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Gebäude (welches sich nicht im ERP befindet) <app:isOperator entity="${entity}"><a href="#" id="show-buildings"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Gebäude hinzufügen" /></a></app:isOperator></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-buildings" targetId="buildings"/>
      </jq:jquery>
      <div class="zusatz-add"id="buildings" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'groupColonyProfile', action:'addBuilding', id:group.id]" update="buildings2" before="showspinner('#buildings2')">

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
      <div class="zusatz-show" id="buildings2">
        <g:render template="buildings" model="${group}"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Planbare Ressourcen <app:isOperator entity="${entity}"><a href="#" id="show-resources"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ressourcen hinzufügen" /></a></app:isOperator></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-resources" targetId="resources"/>
      </jq:jquery>
      <div class="zusatz-add"id="resources" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'groupColonyProfile', action:'addResource', id:group.id]" update="resources2" before="showspinner('#resources2')">
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
              <td><g:select name="classification" from="${['Diese Ressource ist für alle Einrichtungen in dieser Colonia verfügbar.','Diese Ressource steht für alle Einrichtungen im Betrieb zur Verfügung.']}" value="" /></td>
            </tr>
          </table>

          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[resources: resources, group: group]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Einrichtungen <app:isOperator entity="${entity}"><a href="#" id="show-facilities"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Einrichtung hinzufügen" /></a></app:isOperator></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-facilities" targetId="facilities"/>
      </jq:jquery>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'groupColonyProfile', action:'addFacility', id: group.id]" update="facilities2" before="showspinner('#facilities2')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, group: group]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Partner <app:isOperator entity="${entity}"><a href="#" id="show-partners"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Partner hinzufügen" /></a></app:isOperator></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-partners" targetId="partners"/>
      </jq:jquery>
      <div class="zusatz-add"id="partners" style="display:none">
        <g:formRemote name="formRemote5" url="[controller:'groupColonyProfile', action:'addPartner', id:group.id]" update="partners2" before="showspinner('#partners2')">
          <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="partners2">
        <g:render template="partners" model="[partners: partners, group: group]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Pädagogen <app:isOperator entity="${entity}"><a href="#" id="show-educators"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Pädagogen hinzufügen" /></a></app:isOperator></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-educators" targetId="educators"/>
      </jq:jquery>
      <div class="zusatz-add"id="educators" style="display:none">
        <g:formRemote name="formRemote6" url="[controller:'groupColonyProfile', action:'addEducator', id:group.id]" update="educators2" before="showspinner('#educators2')">
          <g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="educators2">
        <g:render template="educators" model="[educators: educators, group: group]"/>
      </div>
    </div>

  </div>
</div>
</body>
