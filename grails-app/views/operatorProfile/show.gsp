<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${operator.profile.fullName}</title>
  <g:javascript library="jquery"/>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${operator.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operatorProfile.fullName.label" default="Name"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${operator.id}" params="[entity:operator.id]">${operator.profile.fullName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operatorProfile.PLZ.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.PLZ') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operatorProfile.city.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operatorProfile.street.label" default="Straße"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operatorProfile.description.label" default="Beschreibung"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.description') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operatorProfile.tel.label" default="Telefon"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.tel') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operatorProfile.showTips.label" default="Zeige Tipps"/>:
          </td>
          <td valign="top" class="value"><app:showBoolean bool="${operator.profile.showTips}"/></td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="operatorProfile.work.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><app:showBoolean bool="${operator.user.enabled}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${operator?.id}">Bearbeiten</g:link>
      <div class="spacer"></div>
    </div>

    <div>
      <h1>Einrichtungen <app:isMeOrAdmin entity="${operator}"><a href="#" id="show-facilities"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Einrichtung hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        hideform = function(){
          $('#facilities').hide('slow') ;
        }
        <jq:toggle sourceId="show-facilities" targetId="facilities"/>
      </jq:jquery>
      <div id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'operatorProfile', action:'addFacility']" update="facilities2" before="hideform()">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="Hinzufügen"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="facilities2">
        <g:render template="facilities" model="${facilities}"/>
      </div>
    </div>

  </div>
</div>
</body>