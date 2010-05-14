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
            <g:message code="operator.profile.name"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${operator.id}" params="[entity:operator.id]">${operator.profile.fullName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operator.profile.email"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'user.email')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operator.profile.zip"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.zip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operator.profile.city"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operator.profile.street"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operator.profile.description"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.description') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="operator.profile.phone"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: operator, field: 'profile.phone') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="showTips"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${operator.profile.showTips}" true="Ja" false="Nein"/></td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="active"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${operator.user.enabled}" true="Ja" false="Nein"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${operator}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${operator?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h1>Einrichtungen <app:isMeOrAdmin entity="${operator}"><a href="#" id="show-facilities"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Einrichtung hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-facilities" targetId="facilities"/>
      </jq:jquery>
      <div id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'operatorProfile', action:'addFacility', id: operator.id]" update="facilities2" before="hideform('#facilities')">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, operator: operator]"/>
      </div>
    </div>

  </div>
</div>
</body>