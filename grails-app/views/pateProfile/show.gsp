<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${pate.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${pate.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>
        <tr class="prop">
          <td height="22" valign="top" class="name-show">
            <g:message code="pate.profile.firstName"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="pate.profile.lastName"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="pate.profile.motherTongue"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="pate.profile.languages"/>:
          </td>
        </tr>

        <tr class="prop">
          <td width="180" valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          <td width="200" valign="top" class="value-show"><g:link action="show" id="${pate.id}" params="[entity:pate.id]">${pate.profile.lastName}</g:link></td>
          <td width="160" valign="top" class="value-show"><app:getLanguages language="${pate.profile.motherTongue}"/></td>
          <td width="170" valign="top" class="value-show">
            <ul>
              <g:each in="${pate.profile.languages}" var="language">
                <li><app:getLanguages language="${language}"/></li>
              </g:each>
            </ul>
          </td>
        </tr>
      </table>
      <table>
        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="pate.profile.zip"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="pate.profile.city"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="pate.profile.street"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="pate.profile.country"/>:
          </td>
        </tr>
        <tr class="prop">
          <td width="101" valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.zip') ?: '<div class="italic">Leer</div>'}</td>
          <td width="220" valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.city') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          <td width="290" valign="top" class="value-show">${fieldValue(bean: pate, field: 'profile.street') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          <td width="210" align="top" class="value-show"><app:getNationalities nationality="${pate.profile.country}"/></td>
        </tr>

       <tr>
        <td colspan="4" height="30" valign="top" class="name-show">
          <g:message code="pate.profile.emails"/>: ${fieldValue(bean: pate, field: 'profile.emails')}
        </td>

       </tr>
      </table>

      <div class="email">
        <table>
          <tr class="prop">
            <app:isAdmin>
            <td width="60" valign="top">
              <g:message code="active"/>:
            </td>
            <td width="50" valign="top" ><g:formatBoolean boolean="${pate.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            </app:isAdmin>
  
            <td width="60" valign="top" >
              <g:message code="pate.profile.email"/>:
            </td>
            <td valign="top" >${fieldValue(bean: pate, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>

          </tr>
        </table>
      </div> <!-- div email close -->

      <div class="buttons">
        <app:isMeOrAdmin entity="${pate}">
          <g:link class="buttonGreen" action="edit" id="${pate?.id}"><g:message code="edit"/></g:link>
        </app:isMeOrAdmin>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    
    <div class="zusatz">
      <h1>Patenkinder <app:isOperator entity="${entity}"><a href="#" id="show-godchildren"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Patenkind hinzufügen" /></a></app:isOperator></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-godchildren" targetId="godchildren"/>
      </jq:jquery>
      <div class="zusatz-add" id="godchildren" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'pateProfile', action:'addGodchildren', id: pate.id]" update="godchildren2" before="hideform('#godchildren')">
          <g:select name="child" from="${allChildren}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="godchildren2">
        <g:render template="godchildren" model="[godchildren: godchildren, pate: pate]"/>
      </div>
    </div>
    </div>
  </div>
</div>
</body>
