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
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="facilityProfile.fullName.label" default="Name"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${facility.id}" params="[entity:facility.id]">${facility.profile.fullName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="facilityProfile.description.label" default="Beschreibung"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: facility, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="facilityProfile.PLZ.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${facility?.profile?.PLZ?.toInteger() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="facilityProfile.city.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: facility, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="facilityProfile.street.label" default="Straße"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: facility, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="facilityProfile.tel.label" default="Telefon"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: facility, field: 'profile.tel') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="facilityProfile.email.label" default="E-Mail"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: facility, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="facilityProfile.enabled.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><app:showBoolean bool="${facility.user.enabled}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${facility?.id}">Bearbeiten</g:link>
      <div class="spacer"></div>
    </div>

    <div>
      <h1>Pädagogen <app:isMeOrAdmin entity="${facility}"><a href="#" id="show-educators"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Pädagogen hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        hideform = function(){
          $('#educators').hide('slow') ;
        }
        <jq:toggle sourceId="show-educators" targetId="educators"/>
      </jq:jquery>
      <div id="educators" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'facilityProfile', action:'addEducator']" update="educators2" before="hideform()">
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
        hideform2 = function(){
          $('#clients').hide('slow') ;
        }
        <jq:toggle sourceId="show-clients" targetId="clients"/>
      </jq:jquery>
      <div id="clients" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'facilityProfile', action:'addClient']" update="clients2" before="hideform2()">
          <g:select name="client" from="${allClients}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="Hinzufügen"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="clients2">
        <g:render template="clients" model="${clients}"/>
      </div>
    </div>

  </div>
</div>
</body>
