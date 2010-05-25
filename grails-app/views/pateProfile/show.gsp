<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${pate.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${pate.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.firstName"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.lastName"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${pate.id}" params="[entity:pate.id]">${pate.profile.lastName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.email"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'user.email')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.country"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.country') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.zip"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.zip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.city"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.street"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.emails"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.emails')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.motherTongue"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: pate, field: 'profile.motherTongue')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="pate.profile.languages"/>:
          </td>
          <td valign="top" class="value">${pate.profile.languages ? g.join(in:pate.profile.languages) : '<div class="italic">Leer</div>'}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="active"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${pate.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${pate}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${pate?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h1>Patenkinder <app:isMeOrAdmin entity="${pate}"><a href="#" id="show-godchildren"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Patenkind hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-godchildren" targetId="godchildren"/>
      </jq:jquery>
      <div id="godchildren" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'pateProfile', action:'addGodchildren', id: pate.id]" update="godchildren2" before="hideform('#godchildren')">
          <g:select name="child" from="${allChildren}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="godchildren2">
        <g:render template="godchildren" model="[godchildren: godchildren, pate: pate]"/>
      </div>
    </div>

  </div>
</div>
</body>
