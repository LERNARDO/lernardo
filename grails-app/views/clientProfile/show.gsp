<head>
  <meta name="layout" content="private"/>
  <title><g:message code="profile"/> - ${client.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile"/> - ${client.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="client.profile.gender"/></td>
          <td valign="top" class="name-show"><g:message code="client.profile.firstName"/></td>
          <td valign="top" class="name-show"><g:message code="client.profile.lastName"/></td>
          <td valign="top" class="name-show"><g:message code="client.profile.birthDate"/></td>
        </tr>

        <tr class="prop">
          <td width="130" valign="top" class="value-show"><erp:showGender gender="${client.profile.gender}"/></td>
          <td width="200" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.firstName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          <td width="270" valign="top" class="value-show"><g:link action="show" id="${client.id}" params="[entity:client.id]">${client.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if></td>
          <td width="35" valign="top" class="value-show"><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          %{--<erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge']">--}%
          <td valign="top" class="name-show">
            <g:if test="${grailsApplication.config.clientProfile.size}">
              <g:message code="client.profile.size"/>
            </g:if>
          </td>
          <td valign="top" class="name-show">
            <g:if test="${grailsApplication.config.clientProfile.weight}">
              <g:message code="client.profile.weight"/>
            </g:if>
          </td>
          %{--</erp:accessCheck>--}%
          <td valign="top" class="name-show">
            <g:message code="client.profile.interests"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="value-show"><g:if test="${grailsApplication.config.clientProfile.size}">${fieldValue(bean: client, field: 'profile.size') + ' cm' ?: '<span class="italic">'+message(code:'noData')+'</span>'}</g:if></td>
          <td valign="top" class="value-show"><g:if test="${grailsApplication.config.clientProfile.weight}">${fieldValue(bean: client, field: 'profile.weight') + ' kg' ?: '<span class="italic">'+message(code:'noData')+'</span>'}</g:if></td>
          <td colspan="2" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.interests') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

      </table>
      <h4><g:message code="client.profile.curAddress"/></h4>
      <div class="contact">
        <table>
          <g:if test="${colonia}">
            <tr class="prop">
              <td valign="top" class="name-show"><g:message code="client.profile.currentColonia"/></td>
            </tr>
            <tr class="prop">
              <td valign="top" class="value-show"><g:link controller="${colonia.type.supertype.name +'Profile'}" action="show" id="${colonia.id}">${colonia.profile.fullName}</g:link></td>
            </tr>
          </g:if>

          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="client.profile.currentStreet"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.currentZip"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.currentCity"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.currentCountry"/></td>
          </tr>

          <tr class="prop">
            <td width="270" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentStreet') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td width="60" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
            <td width="205" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentCity') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td width="165" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentCountry') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
          </tr>

        </table>
      </div>
      <h4><g:message code="client.profile.origin"/></h4>
      <div class="contact">
        <table>

          <tr class="prop">
            <td valign="top" class="name-show"><g:if test="${grailsApplication.config.clientProfile.originCity}"><g:message code="client.profile.originCity"/></g:if></td>
            <td valign="top" class="name-show"><g:if test="${grailsApplication.config.clientProfile.originZip}"><g:message code="client.profile.originZip"/></g:if></td>
            <td valign="top" class="name-show"><g:message code="client.profile.originCountry"/></td>
          </tr>

          <tr class="prop">
            <td width="205" valign="top" class="value-show"><g:if test="${grailsApplication.config.clientProfile.originCity}">${fieldValue(bean: client, field: 'profile.originCity') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</g:if></td>
            <td width="60" valign="top" class="value-show"><g:if test="${grailsApplication.config.clientProfile.originZip}">${fieldValue(bean: client, field: 'profile.originZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</g:if></td>
            <td width="170" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.originCountry') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

        </table>
      </div>
      <h4><g:message code="client.profile.more"/></h4>
      <div class="contact">
        <table>

          <tr class="prop">
            <td valign="top" class="name-show"><g:if test="${grailsApplication.config.clientProfile.familyStatus}"><g:message code="client.profile.familyStatus"/></g:if></td>
            <td valign="top" class="name-show"><g:message code="client.profile.languages"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.school"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolLevel"/></td>
          </tr>

          <tr class="prop">
            <td width="160" valign="top" class="value-show"><g:if test="${grailsApplication.config.clientProfile.familyStatus}"><erp:getFamilyStatus status="${client.profile.familyStatus}"/></g:if></td>
            <td width="250" valign="top" class="value-show-block">
              <g:if test="${client.profile.languages}">
              <ul>
                <g:each in="${client.profile.languages}" var="language">
                  <li><erp:getLanguages language="${language}"/></li>
                </g:each>
              </ul>
              </g:if>
              <g:else>
                <div class="italic"><g:message code="none"/></div>
              </g:else>
            </td>
            <td width="230" valign="top" class="value-show"><g:if test="${school}"><g:link controller="${school.type.supertype.name +'Profile'}" action="show" id="${school.id}">${school.profile.fullName}</g:link></g:if><g:else><div class="italic"><g:message code="client.noSchoolEntered"/></div></g:else></td>
            <td width="210" valign="top" class="value-show">
              <g:if test="${client.profile.schoolLevel}">
                <g:if test="${grailsApplication.config.project == 'sueninos'}">
                  <erp:getSchoolLevel level="${client.profile.schoolLevel}"/>
                </g:if>
                <g:if test="${grailsApplication.config.project == 'noe'}">
                  <erp:getSchoolLevelNoe level="${client.profile.schoolLevel}"/>
                </g:if>
              </g:if>
              <g:else>
                <div class="italic"><g:message code="none"/></div>
              </g:else>
            </td>
          </tr>

          <g:if test="${grailsApplication.config.project == 'sueninos'}">
          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="client.profile.schoolDropout"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolDropoutDate"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolDropoutReason"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.schoolDropout}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            <td valign="top" class="value-show"><g:if test="${client.profile.schoolDropout}"><g:formatDate date="${client.profile.schoolDropoutDate}" format="dd. MM. yyyy"/></g:if><g:else><div class="italic">kein Datum eingetragen</div></g:else></td>
            <td colspan="2" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.schoolDropoutReason') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>
          </g:if>

          <g:if test="${grailsApplication.config.project == 'sueninos'}">
          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="client.profile.schoolRestart"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolRestartDate"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolRestartReason"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.schoolRestart}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            <td valign="top" class="value-show"><g:if test="${client.profile.schoolRestart}"><g:formatDate date="${client.profile.schoolRestartDate}" format="dd. MM. yyyy"/></g:if><g:else><div class="italic">kein Datum eingetragen</div></g:else></td>
            <td colspan="2" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.schoolRestartReason') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>
          </g:if>

          <g:if test="${grailsApplication.config.project == 'sueninos'}">
          <g:if test="${client.profile.job}">
            <tr class="prop">
              <td valign="top" class="name-show"><g:message code="client.profile.job"/></td>
              <td valign="top" class="name-show"><g:message code="client.profile.jobType"/></td>
              <td valign="top" class="name-show"><g:message code="client.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
              <td valign="top" class="name-show"><g:message code="client.profile.jobFrequency"/></td>
            </tr>

            <tr class="prop">
              <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
              <td valign="top" class="value-show">
                <g:if test="${client.profile.jobtypes}">
                  <ul>
                    <g:each in="${client.profile.jobtypes}" var="jobtype">
                      <li><erp:getJobType job="${jobtype}"/></li>
                    </g:each>
                  </ul>
                </g:if>
                %{--<g:if test="${client.profile.jobType}">--}%
                %{--<erp:getJobType job="${client.profile.jobType}"/>--}%
                %{--</g:if>--}%<g:else><div class="italic"><g:message code="client.noWorkEntered"/></div></g:else></td>
              <td valign="top" class="value-show">${client?.profile?.jobIncome?.toInteger() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
              <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.jobFrequency') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            </tr>
          </g:if>
          </g:if>

          <g:if test="${client.profile.support}">
            <tr class="prop">
              <td valign="top" class="name-show"><g:message code="client.profile.support"/></td>
              <td valign="top" class="name-show"><g:message code="client.profile.supportDescription"/></td>
            </tr>
  
            <tr class="prop">
              <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.support}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
              <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.supportDescription') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            </tr>
          </g:if>

          <tr class="prop">
            <td valign="top" class="name-show"><g:if test="${grailsApplication.config.clientProfile.citizenship}">Staatsbürgerschaft</g:if></td>
            <td valign="top" class="name-show"><g:if test="${grailsApplication.config.clientProfile.socialSecurityNumber}">Sozialversicherungsnummer</g:if></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show"><g:if test="${grailsApplication.config.clientProfile.citizenship}">${fieldValue(bean: client, field: 'profile.citizenship') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</g:if></td>
            <td valign="top" class="value-show"><g:if test="${grailsApplication.config.clientProfile.socialSecurityNumber}">${fieldValue(bean: client, field: 'profile.socialSecurityNumber') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</g:if></td>
          </tr>

          %{--<g:if test="${grailsApplication.config.clientProfile.contact}">

          <tr>
            <td colspan="4">Kontakt im Notfall</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name-show">Name:</td>
            <td valign="top" class="name-show">Land:</td>
            <td valign="top" class="name-show">PLZ:</td>
            <td valign="top" class="name-show">Stadt:</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.contactName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.contactCountry') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.contactZip') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.contactCity') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name-show">Straße:</td>
            <td valign="top" class="name-show">Telefon:</td>
            <td colspan="2" valign="top" class="name-show">E-Mail:</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.contactStreet') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.contactPhone') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td colspan="2" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.contactMail') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          </g:if>--}%

        </table>
      </div>

      <div class="email">
        <table>
          <tr class="prop">
            <erp:isOperator entity="${currentEntity}">
              <td width="60" valign="top" class="bold"><g:message code="active"/></td>
              <td width="50" valign="top"><g:formatBoolean boolean="${client.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            </erp:isOperator>
            <td width="60" valign="top" class="bold"><g:message code="client.profile.email"/>:</td>
            <td valign="top">${fieldValue(bean: client, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </table>
      </div>
    </div>

    <erp:isMeOrAdminOrOperator entity="${client}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${client?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isMeOrAdminOrOperator>

    <div class="zusatz">
      <h5><g:message code="client.profile.schoolPerformance"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><a onclick="toggle('#performances');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Performance hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="performances" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'clientProfile', action:'addPerformance', id:client.id]" update="performances2" before="showspinner('#performances2')">
          <table>
            <tr>
              <td valign="middle"><g:message code="date"/>:</td>
              <td><g:datePicker name="date" value="" precision="day"/></td>
            </tr>
            <tr>
              <td valign="top"><g:message code="text"/>:</td>
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
        <g:render template="performances" model="[client: client, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="client.profile.healthNotes"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><a onclick="toggle('#healths');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Gesundheitseintrag hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="healths" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'clientProfile', action:'addHealth', id:client.id]" update="healths2" before="showspinner('#healths2')">
          <table>
            <tr>
              <td valign="middle"><g:message code="date"/>:</td>
              <td><g:datePicker name="date" value="" precision="day"/></td>
            </tr>
            <tr>
              <td valign="top"><g:message code="text"/>:</td>
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
        <g:render template="healths" model="[client: client, entity: currentEntity]"/>
      </div>
    </div>

    <g:if test="${grailsApplication.config.project == 'sueninos'}">
    <div class="zusatz">
      <h5><g:message code="client.profile.materials"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><a onclick="toggle('#materials');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Material hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="materials" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'clientProfile', action:'addMaterial', id:client.id]" update="materials2" before="showspinner('#materials2')">
          <table>
            <tr>
              <td valign="middle"><g:message code="date"/>:</td>
              <td><g:datePicker name="date" value="" precision="day"/></td>
            </tr>
            <tr>
              <td valign="top"><g:message code="text"/>:</td>
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
        <g:render template="materials" model="[client: client, entity: currentEntity]"/>
      </div>
    </div>
    </g:if>

    <div class="zusatz">
      <h5><g:message code="client.profile.inOut" args="[grailsApplication.config.projectName]"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><a onclick="toggle('#dates');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Datum hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="dates" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'clientProfile', action:'addDate', id:client.id]" update="dates2" before="showspinner('#dates2')">
          <g:textField name="date" size="12" class="datepicker" value=""/>
          %{--<g:datePicker name="date" value="" precision="day"/>--}%
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="dates2">
        <g:render template="dates" model="[client: client, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="client.profile.collectors"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><a onclick="toggle('#collectors');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Abholberechtigten hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="collectors" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'clientProfile', action:'addCollector', id:client.id]" update="collectors2" before="showspinner('#collectors2')">
          <table>
            <tr>
              <td valign="top">Name: </td>
              <td><g:textField size="30" name="text" value=""/></td>
            </tr>
            <tr>
              <td></td>
              <td><g:submitButton name="button" value="${message(code:'add')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="collectors2">
        <g:render template="collectors" model="[client: client, entity: currentEntity]"/>
      </div>
    </div>

    <g:if test="${grailsApplication.config.clientProfile.contact}">
      <div class="zusatz">
        <h5>Kontakt im Notfall <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#contacts');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ansprechperson hinzufügen"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="contacts" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'clientProfile', action:'addContact', id:client.id]" update="contacts2" before="showspinner('#contacts2')">

            <table>
              <tr>
                <td><g:message code="contact.firstName"/>:</td>
                <td><g:textField name="firstName" size="30"/></td>
              </tr>
              <tr>
                <td><g:message code="contact.lastName"/>:</td>
                <td><g:textField name="lastName" size="30"/></td>
              </tr>
              <tr>
                <td><g:message code="contact.country"/>:</td>
                <td><g:textField name="country" size="30"/></td>
              </tr>
              <tr>
                <td><g:message code="contact.zip"/>:</td>
                <td><g:textField name="zip" size="30"/></td>
              </tr>
              <tr>
                <td><g:message code="contact.city"/>:</td>
                <td><g:textField name="city" size="30"/></td>
              </tr>
              <tr>
                <td><g:message code="contact.street"/>:</td>
                <td><g:textField name="street" size="30"/></td>
              </tr>
              <tr>
                <td><g:message code="contact.phone"/>:</td>
                <td><g:textField name="phone" size="30"/></td>
              </tr>
              <tr>
                <td><g:message code="contact.email"/>:</td>
                <td><g:textField name="email" size="30"/></td>
              </tr>
              <tr>
                <td><g:message code="contact.function"/>:</td>
                <td><g:textField name="function" size="30"/></td>
              </tr>
            </table>

            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="contacts2">
          <g:render template="contacts" model="[client: client, entity: currentEntity]"/>
        </div>
      </div>
    </g:if>

    <div class="zusatz">
      <h5>Paten</h5>
      <div class="zusatz-show">
        <g:if test="${pates}">
          <ul>
            <g:each in="${pates}" var="pate">
              <li style="list-style-type: disc; margin-left: 15px"><g:link controller="pateProfile" action="show" id="${pate.id}" params="[entity: pate.id]">${pate.profile.fullName}</g:link></li>
            </g:each>
          </ul>
        </g:if>
        <g:else>
          <span class="italic">Dieser Betreute hat bisher keinen Paten!</span>
        </g:else>
      </div>
    </div>

    <g:render template="/templates/links" model="[entity: client]"/>

  </div>
</div>
</body>
