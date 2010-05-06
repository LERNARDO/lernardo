<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${educator.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${educator.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.title"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.title') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.firstName"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.lastName"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${educator.id}" params="[entity:educator.id]">${educator.profile.lastName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.birthDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${educator.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.gender"/>:
          </td>
          <td valign="top" class="value"><app:showGender gender="${educator.profile.gender}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.email"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr>
          <td><span class="bold">Derzeitige Adresse</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.currentStreet"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.currentStreet') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.currentCity"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.currentCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.currentZip"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.currentZip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.currentCountry"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.currentCountry') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr>
          <td><span class="bold">Herkunft</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.originStreet"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.originStreet') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.originCity"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.originCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.originZip"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.originZip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.originCountry"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.originCountry') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr>
          <td><span class="bold">Kontakt im Notfall</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.contactStreet"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.contactStreet') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.contactCity"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.contactCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.contactZip"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.contactZip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.contactPhone"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.contactPhone') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.contactMail"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.contactMail') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.languages"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.languages')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.education"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.education') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.interests"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.interests') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.inChargeOf"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.inChargeOf') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.employment"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: educator, field: 'profile.employment') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="educator.profile.enlisted"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: enlistedBy, field: 'profile.fullName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${educator}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${educator?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h1>Eintrittsdaten / Austrittsdaten <app:isMeOrAdmin entity="${educator}"><a href="#" id="show-dates"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Datum hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        hideform = function(){
          $('#dates').hide('slow') ;
        }
        <jq:toggle sourceId="show-dates" targetId="dates"/>
      </jq:jquery>
      <div id="dates" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'educatorProfile', action:'addDate', id:educator.id]" update="dates2" before="hideform()">
          <g:datePicker name="date" value="" precision="day"/>
          <g:hiddenField name="type" value="${educator.profile.dates.size() % 2 == 0 ? 'join' : 'end'}" />
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="dates2">
        <g:render template="dates" model="${educator}"/>
      </div>
    </div>

  </div>
</div>
</body>
