<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${client.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${client.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>
        <tbody>
        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="client.profile.gender"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="client.profile.firstName"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="client.profile.lastName"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="client.profile.birthDate"/>:
          </td>
        </tr>

        <tr class="prop">
          <td width="130" valign="top" class="value-show"><app:showGender gender="${client.profile.gender}"/></td>
          <td width="200" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          <td width="270" valign="top" class="value-show"><g:link action="show" id="${client.id}" params="[entity:client.id]">${client.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if></td>
          <td width="35" valign="top" class="value-show"><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          %{--<app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge']">--}%
          <td valign="top" class="name-show">
            <g:message code="client.profile.size"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="client.profile.weight"/>:
          </td>
          %{--</app:hasRoleOrType>--}%
          <td valign="top" class="name-show">
            <g:message code="client.profile.interests"/>:
          </td>
        </tr>
        <tr class="prop">
          <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.size') + ' cm' ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.weight') + ' kg' ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          <td colspan="2" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.interests') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>
      </table>
      <h4>Derzeitige Adresse</h4>
        <div class="contact">
          <table>
            <tr class="prop">
              <td valign="top" class="name-show">
                      <g:message code="client.profile.currentColonia"/>:
              </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="value-show"><g:link controller="${colonia.type.supertype.name +'Profile'}" action="show" id="${colonia.id}">${colonia.profile.fullName}</g:link></td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name-show">
                <g:message code="client.profile.currentStreet"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.currentZip"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.currentCity"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.currentCountry"/>:
              </td>
            </tr>
            <tr class="prop">
              <td width="270" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentStreet') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
              <td width="60" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentZip') ?: '<div class="italic">leer</div>'}</td>
              <td width="205" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
              <td width="165" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentCountry') ?: '<div class="italic">leer</div>'}</td>
            </tr>
          </table>
        </div>
      <h4>Herkunft</h4>
        <div class="contact">
          <table>
            <tr class="prop">
              <td valign="top" class="name-show">
                <g:message code="client.profile.originCity"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.originZip"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.originCountry"/>:
              </td>
            </tr>
            <tr class="prop">
              <td width="205" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.originCity') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
              <td width="60" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.originZip') ?: '<div class="italic">leer</div>'}</td>
              <td width="170" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.originCountry') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
            </tr>
          </table>
        </div>
      <h4>Weitere Daten</h4>
        <div class="contact">
          <table>
            <tr class="prop">
              <td valign="top" class="name-show">
                <g:message code="client.profile.familyStatus"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.languages"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.school"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.schoolLevel"/>:
              </td>
            </tr>
            <tr class="prop">
              <td width="160" valign="top" class="value-show"><app:getFamilyStatus status="${client.profile.familyStatus}"/></td>
              <td width="250" valign="top" class="value-show-block">
                <ul>
                  <g:each in="${client.profile.languages}" var="language">
                    <li><app:getLanguages language="${language}"/></li>
                  </g:each>
                </ul>
              </td>
              <td width="230" valign="top" class="value-show"><g:link controller="${school.type.supertype.name +'Profile'}" action="show" id="${school.id}">${school.profile.fullName}</g:link></td>
              <td width="210" valign="top" class="value-show"><app:getSchoolLevel level="${client.profile.schoolLevel}"/></td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name-show">
                <g:message code="client.profile.schoolDropout"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.schoolDropoutDate"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.schoolDropoutReason"/>:
              </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.schoolDropout}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
              <td valign="top" class="value-show"><g:formatDate date="${client.profile.schoolDropoutDate}" format="dd. MM. yyyy"/></td>
              <td colspan="2" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.schoolDropoutReason') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name-show">
                <g:message code="client.profile.schoolRestart"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.schoolRestartDate"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.schoolRestartReason"/>:
              </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.schoolRestart}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
              <td valign="top" class="value-show"><g:formatDate date="${client.profile.schoolRestartDate}" format="dd. MM. yyyy"/></td>
              <td colspan="2" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.schoolRestartReason') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name-show">
                <g:message code="client.profile.job"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.jobType"/>:
              </td>
               <td valign="top" class="name-show">
                <g:message code="client.profile.jobIncome"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.jobFrequency"/>:
              </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
              <td valign="top" class="value-show"><g:if test="${client.profile.jobType}"><app:getJobType job="${client.profile.jobType}"/></g:if></td>
              <td valign="top" class="value-show">${client?.profile?.jobIncome?.toInteger() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
              <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.jobFrequency') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
            </tr>
            <tr class="prop">
              <td valign="top" class="name-show">
                <g:message code="client.profile.support"/>:
              </td>
              <td valign="top" class="name-show">
                <g:message code="client.profile.supportDescription"/>:
              </td>
            </tr>
            <tr class="prop">
              <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.support}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
              <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.supportDescription') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
              
            </tr>
          </table>
        </div>

      <div class="email">
        <table>
          <tr class="prop">
            <app:isAdmin>
            <td width="60" valign="top" >
              <g:message code="active"/>:
            </td>
            <td width="50" valign="top" ><g:formatBoolean boolean="${client.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            </app:isAdmin>
            <td width="60" valign="top" >
            <g:message code="client.profile.email"/>:
            </td>
            <td  valign="top" >${fieldValue(bean: client, field: 'user.email') ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </table>
      </div>
    </div>

    <app:isMeOrAdmin entity="${client}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${client?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div class="zusatz">
      <h5>Schulleistungungen <app:isMeOrAdmin entity="${client}"><a href="#" id="show-performances"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Performance hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-performances" targetId="performances"/>
      </jq:jquery>
      <div class="zusatz-add" id="performances" style="display:none">
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
      <div class="zusatz-show" id="performances2">
        <g:render template="performances" model="${client}"/>
      </div>
    </div>

    <div class="zusatz">
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
      <div class="zusatz-show" id="healths2">
        <g:render template="healths" model="${client}"/>
      </div>
    </div>

    <div class="zusatz">
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
      <div class="zusatz-show" id="materials2">
        <g:render template="materials" model="${client}"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Eintrittsdaten / Austrittsdaten <app:isMeOrAdmin entity="${client}"><a href="#" id="show-dates"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Datum hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-dates" targetId="dates"/>
      </jq:jquery>
      <div id="dates" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'clientProfile', action:'addDate', id:client.id]" update="dates2" before="hideform('#dates')">
          <g:datePicker name="date" value="" precision="day"/>
          <g:hiddenField name="type" value="${client.profile.dates.size() % 2 == 0 ? 'join' : 'end'}" />
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="dates2">
        <g:render template="dates" model="${client}"/>
      </div>
    </div>

  </div>
</div>
</body>
