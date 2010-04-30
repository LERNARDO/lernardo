<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${partner.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${partner.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.fullName.label" default="Name"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.fullName.label" default="E-Mail"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'user.email')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.website.label" default="Webseite"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.website') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.description.label" default="Beschreibung"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.description') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.country.label" default="Land"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.country') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.zip.label" default="PLZ"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.zip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.city.label" default="Stadt"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.street.label" default="Straße"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partnerProfile.phone.label" default="Telefon"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.phone') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="parentProfile.work.label" default="Aktiv"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${partner.user.enabled}" true="Ja" false="Nein"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${partner}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${partner?.id}">Bearbeiten</g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h1>Dienstleistungen <app:isMeOrAdmin entity="${partner}"><a href="#" id="show-services"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Service hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        hideform = function(){
          $('#services').hide('slow') ;
        }
        <jq:toggle sourceId="show-services" targetId="services"/>
      </jq:jquery>
      <div id="services" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'partnerProfile', action:'addService', id:partner.id]" update="services2" before="hideform()">
          <g:textField name="service" size="30"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="Hinzufügen"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="services2">
        <g:render template="services" model="${partner}"/>
      </div>
    </div>

    <div>
      <h1>Ansprechpersonen <app:isMeOrAdmin entity="${partner}"><a href="#" id="show-contacts"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ansprechperson hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        hideform2 = function(){
          $('#contacts').hide('slow') ;
        }
        <jq:toggle sourceId="show-contacts" targetId="contacts"/>
      </jq:jquery>
      <div id="contacts" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'partnerProfile', action:'addContact', id:partner.id]" update="contacts2" before="hideform2()">

          Vorname: <g:textField name="firstName" size="30"/>
          Nachname: <g:textField name="lastName" size="30"/>
          Land: <g:textField name="country" size="30"/>
          PLZ: <g:textField name="zip" size="30"/>
          Stadt: <g:textField name="city" size="30"/>
          Straße: <g:textField name="street" size="30"/>
          Telefon: <g:textField name="phone" size="30"/>
          E-Mail: <g:textField name="email" size="30"/>
          Funktion: <g:textField name="function" size="30"/>        

          <div class="spacer"></div>
          <g:submitButton name="button" value="Hinzufügen"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="contacts2">
        <g:render template="contacts" model="${partner}"/>
      </div>
    </div>

  </div>
</div>
</body>
