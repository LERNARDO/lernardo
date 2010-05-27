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
            <g:message code="partner.profile.name"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.email"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'user.email')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.website"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.website') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.description"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.description') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.country"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.country') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.zip"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.zip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.city"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.street"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.phone"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: partner, field: 'profile.phone') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.services"/>:
          </td>
          <td valign="top" class="value">
            <ul>
              <g:each in="${partner.profile.services}" var="service">
                <li><app:getPartnerService service="${service}"/></li>
              </g:each>
            </ul>
            %{-- ${fieldValue(bean: partner, field: 'profile.phone') ?: '<div class="italic">keine Daten eingetragen</div>'}--}%
          </td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="active"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${partner.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${partner}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${partner?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

%{--    <div>
      <h1>Dienstleistungen <app:isMeOrAdmin entity="${partner}"><a href="#" id="show-services"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Service hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-services" targetId="services"/>
      </jq:jquery>
      <div id="services" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'partnerProfile', action:'addService', id:partner.id]" update="services2" before="hideform('#services')">
          <g:textField name="service" size="30"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="services2">
        <g:render template="services" model="${partner}"/>
      </div>
    </div>--}%

    <div>
      <h5>Ansprechpersonen <app:isMeOrAdmin entity="${partner}"><a href="#" id="show-contacts"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ansprechperson hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-contacts" targetId="contacts"/>
      </jq:jquery>
      <div id="contacts" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'partnerProfile', action:'addContact', id:partner.id]" update="contacts2" before="hideform('#contacts')">

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
        <g:render template="contacts" model="${partner}"/>
      </div>
    </div>

  </div>
</div>
</body>
