<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${client.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${client.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.firstName"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.lastName"/>:
          </td>
          <td valign="top" class="value"><g:link action="show" id="${client.id}" params="[entity:client.id]">${client.profile.lastName}</g:link></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.birthDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.email"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.gender"/>:
          </td>
          <td valign="top" class="value"><app:showGender gender="${client.profile.gender}"/></td>
        </tr>

        <tr>
          <td><span class="bold">Derzeitige Adresse</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.currentStreet"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.currentStreet') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.currentCity"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.currentCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.currentZip"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.currentZip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.currentCountry"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.currentCountry') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr>
          <td><span class="bold">Herkunft</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.originCity"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.originCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.originZip"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.originZip') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.originCountry"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.originCountry') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr>
          <td><span class="bold">Weitere Daten</span></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.familyStatus"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.familyStatus')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.languages"/>:
          </td>
          <td valign="top" class="value">
            <ul>
              <g:each in="${client.profile.languages}" var="language">
                <li><app:getLanguages language="${language}"/></li>
              </g:each>
            </ul>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.schoolLevel"/>:
          </td>
          <td valign="top" class="value"><app:getSchoolLevel level="${client.profile.schoolLevel}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.schoolDropout"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${client.profile.schoolDropout}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.schoolDropoutReason"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.schoolDropoutReason') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.schoolDropoutDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.schoolDropoutDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.schoolRestart"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${client.profile.schoolRestart}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.schoolRestartReason"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.schoolRestartReason') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.schoolRestartDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${client.profile.schoolRestartDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.interests"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.interests') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

       <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.size"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.size') + ' cm' ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.weight"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.weight') + ' kg' ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.job"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${client.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.jobType"/>:
          </td>
          <td valign="top" class="value"><g:if test="${client.profile.jobType}"><app:getJobType job="${client.profile.jobType}"/></g:if></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.jobIncome"/>:
          </td>
          <td valign="top" class="value">${client?.profile?.jobIncome?.toInteger() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.jobFrequency"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.jobFrequency') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.support"/>:
          </td>
          <td valign="top" class="value"><g:formatBoolean boolean="${client.profile.support}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
        </tr>

         <tr class="prop">
          <td valign="top" class="name">
            <g:message code="client.profile.supportDescription"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: client, field: 'profile.supportDescription') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <app:isAdmin>
          <tr class="prop">
            <td valign="top" class="name">
              <g:message code="active"/>:
            </td>
            <td valign="top" class="value"><g:formatBoolean boolean="${client.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
          </tr>
        </app:isAdmin>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${client}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${client?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h5>Schulleistungungen <app:isMeOrAdmin entity="${client}"><a href="#" id="show-performances"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Performance hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-performances" targetId="performances"/>
      </jq:jquery>
      <div id="performances" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'clientProfile', action:'addPerformance', id:client.id]" update="performances2" before="hideform('#performances')">
          <g:hiddenField name="type" value="performance" />
          <table>
            <tr>
              <td>Datum:</td>
              <td><g:datePicker name="date" value="" precision="day"/></td>
            </tr>
            <tr>
              <td>Text:</td>
              <td><g:textArea rows="5" cols="100" name="text" value=""/></td>
            </tr>
            <tr>
              <td></td>
              <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>
      <div id="performances2">
        <g:render template="performances" model="${client}"/>
      </div>
    </div>

    <div>
      <h5>Gesundheitseinträge <app:isMeOrAdmin entity="${client}"><a href="#" id="show-healths"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Gesundheitseintrag hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-healths" targetId="healths"/>
      </jq:jquery>
      <div id="healths" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'clientProfile', action:'addHealth', id:client.id]" update="healths2" before="hideform('#healths')">
          <g:hiddenField name="type" value="health" />
          <table>
            <tr>
              <td>Datum:</td>
              <td><g:datePicker name="date" value="" precision="day"/></td>
            </tr>
            <tr>
              <td>Text:</td>
              <td><g:textArea rows="5" cols="100" name="text" value=""/></td>
            </tr>
            <tr>
              <td></td>
              <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>
      <div id="healths2">
        <g:render template="healths" model="${client}"/>
      </div>
    </div>

    <div>
      <h5>Erhaltene Materialien <app:isMeOrAdmin entity="${client}"><a href="#" id="show-materials"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Material hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-materials" targetId="materials"/>
      </jq:jquery>
      <div id="materials" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'clientProfile', action:'addMaterial', id:client.id]" update="materials2" before="hideform('#materials')">
          <g:hiddenField name="type" value="material" />
          <table>
            <tr>
              <td>Datum:</td>
              <td><g:datePicker name="date" value="" precision="day"/></td>
            </tr>
            <tr>
              <td>Text:</td>
              <td><g:textArea rows="5" cols="100" name="text" value=""/></td>
            </tr>
            <tr>
              <td></td>
              <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>
      <div id="materials2">
        <g:render template="materials" model="${client}"/>
      </div>
    </div>

  </div>
</div>
</body>
