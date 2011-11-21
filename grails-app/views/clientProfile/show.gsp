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
    <div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="gender"/>:</td>
          <td class="two"><erp:showGender gender="${client.profile.gender}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="firstName"/>:</td>
          <td class="two">${fieldValue(bean: client, field: 'profile.firstName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="lastName"/>:</td>
          <td class="two"><g:link action="show" id="${client.id}" params="[entity:client.id]">${client.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="birthDate"/>:</td>
          <td class="two"><g:formatDate date="${client.profile.birthDate}" format="dd. MM. yyyy"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="client.profile.interests"/>:</td>
          <td class="two">${fieldValue(bean: client, field: 'profile.interests') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        </tbody>
      </table>

      <h4><g:message code="client.profile.curAddress"/></h4>
      <div>
        <table width="100%">

          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="street"/></td>
            <td valign="top" class="name-show"><g:message code="zip"/></td>
            <td valign="top" class="name-show"><g:message code="groupColony"/></td>
            <td valign="top" class="name-show"><g:message code="country"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentStreet') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
            <td valign="top" class="value-show"><g:if test="${colonia}"><g:link controller="${colonia.type.supertype.name +'Profile'}" action="show" id="${colonia.id}">${colonia.profile.fullName}</g:link></g:if></td>
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.currentCountry') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
          </tr>

        </table>
      </div>
      <h4><g:message code="client.profile.origin"/></h4>
      <div>
        <table width="100%">

          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="city"/></td>
            <td valign="top" class="name-show"><g:message code="zip"/></td>
            <td valign="top" class="name-show"><g:message code="country"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.originCity') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.originZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}</td>
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.originCountry') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

        </table>
      </div>
      <h4><g:message code="client.profile.more"/></h4>
      <div>
        <table width="100%">

          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="client.profile.familyStatus"/></td>
            <td valign="top" class="name-show"><g:message code="languages"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.school"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolLevel"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show">${client.profile.familyStatus}</td>
            <td valign="top" class="value-show-block">
              <g:if test="${client.profile.languages}">
              <ul>
                <g:each in="${client.profile.languages}" var="language">
                  <li>${language}</li>
                </g:each>
              </ul>
              </g:if>
              <g:else>
                <div class="italic"><g:message code="none"/></div>
              </g:else>
            </td>
            <td valign="top" class="value-show">
              ${fieldValue(bean: client, field: 'profile.school').decodeHTML() ?: '<span class="italic">'+message(code:'client.noSchoolEntered')+'</span>'}
            </td>
            <td valign="top" class="value-show">
              <g:if test="${client.profile.schoolLevel}">
                ${client.profile.schoolLevel}
              </g:if>
              <g:else>
                <div class="italic"><g:message code="none"/></div>
              </g:else>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="client.profile.schoolDropout"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolDropoutDate"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolDropoutReason"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.schoolDropout}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            <td valign="top" class="value-show"><g:if test="${client.profile.schoolDropout}"><g:formatDate date="${client.profile.schoolDropoutDate}" format="dd. MM. yyyy" /></g:if><g:else><div class="italic"><g:message code="noDate"/></div></g:else></td>
            <td colspan="2" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.schoolDropoutReason') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="client.profile.schoolRestart"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolRestartDate"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.schoolRestartReason"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show"><g:formatBoolean boolean="${client.profile.schoolRestart}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
            <td valign="top" class="value-show"><g:if test="${client.profile.schoolRestart}"><g:formatDate date="${client.profile.schoolRestartDate}" format="dd. MM. yyyy" /></g:if><g:else><div class="italic"><g:message code="noDate"/></div></g:else></td>
            <td colspan="2" valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.schoolRestartReason') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

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
                  <ul style="margin-left: 5px;">
                    <g:each in="${client.profile.jobtypes}" var="jobtype">
                      <li style="list-style-type: disc;">${jobtype}</li>
                    </g:each>
                  </ul>
                </g:if>
                <g:else>
                  <div class="italic">
                    <g:message code="client.noWorkEntered"/>
                  </div>
                </g:else>
              </td>
              <td valign="top" class="value-show">${client?.profile?.jobIncome?.toInteger() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
              <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.jobFrequency') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            </tr>
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
            <td valign="top" class="name-show"><g:message code="client.profile.citizenship"/></td>
            <td valign="top" class="name-show"><g:message code="client.profile.socialSecurityNumber"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.citizenship').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
            <td valign="top" class="value-show">${fieldValue(bean: client, field: 'profile.socialSecurityNumber') ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
          </tr>

        </table>
      </div>

      <div class="email">
        <table width="100%">
          <tr>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
              <td>
                <span class="bold"><g:message code="active"/> </span>
                <g:formatBoolean boolean="${client.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:accessCheck>
            <td>
              <span class="bold"><g:message code="email"/>: </span>
              ${fieldValue(bean: client, field: 'user.email') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${client}">
              <td>
                <g:form controller="profile" action="changePassword" id="${client.id}">
                  <span class="bold"><g:message code="password"/>: </span>
                  <g:submitButton name="submit" value="${message(code: 'change')}"/>
                  <div class="clear"></div>
                </g:form>
              </td>
            </erp:accessCheck>
          </tr>
        </table>
      </div>
    </div>

    <div class="buttons">
      <g:form id="${client?.id}">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${client}" facilities="${facilities}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        </erp:accessCheck>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: client.id)}" /></div>
        </erp:accessCheck>
        <erp:getFavorite entity="${client}"/>
      </g:form>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="client.profile.schoolPerformance"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']"><a onclick="toggle('#performances');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="performances" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'clientProfile', action:'addPerformance', id:client.id]" update="performances2" before="showspinner('#performances2');" after="toggle('#performances');">
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
              <td><g:submitButton name="button" value="${message(code:'add')}"/> <span class="gray"><g:message code="maxEntryPerDay"/></span></td>
            </tr>
          </table>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="performances2">
        <g:render template="performances" model="[client: client, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="client.profile.healthNotes"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']"><a onclick="toggle('#healths');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="healths" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'clientProfile', action:'addHealth', id:client.id]" update="healths2" before="showspinner('#healths2');" after="toggle('#healths');">
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
              <td><g:submitButton name="button" value="${message(code:'add')}"/> <span class="gray"><g:message code="maxEntryPerDay"/></span></td>
            </tr>
          </table>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="healths2">
        <g:render template="healths" model="[client: client, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="client.profile.materials"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']"><a onclick="toggle('#materials');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="materials" style="display:none">
        <g:formRemote name="formRemote3" url="[controller:'clientProfile', action:'addMaterial', id:client.id]" update="materials2" before="showspinner('#materials2');" after="toggle('#materials');">
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
              <td><g:submitButton name="button" value="${message(code:'add')}"/> <span class="gray"><g:message code="maxEntryPerDay"/></span></td>
            </tr>
          </table>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="materials2">
        <g:render template="materials" model="[client: client, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="client.profile.inOut" args="[grailsApplication.config.customerName]"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']"><a onclick="toggle('#dates');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="dates" style="display:none">
        <g:formRemote name="formRemote4" url="[controller:'clientProfile', action:'addDate', id:client.id]" update="dates2" before="showspinner('#dates2');" after="toggle('#dates');">
          <g:textField name="date" size="12" class="datepicker" value=""/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="dates2">
        <g:render template="dates" model="[client: client, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="client.profile.collectors"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']"><a onclick="toggle('#collectors');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="collectors" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'clientProfile', action:'addCollector', id:client.id]" update="collectors2" before="showspinner('#collectors2');" after="toggle('#collectors');">
          <table>
            <tr>
              <td valign="top"><g:message code="name"/>: </td>
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

    <div class="zusatz">
      <h5><g:message code="educator.profile.emContact"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#contacts');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="contacts" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'clientProfile', action:'addContact', id:client.id]" update="contacts2" before="showspinner('#contacts2');" after="toggle('#contacts');">

          <table>
            <tr>
              <td><g:message code="firstName"/>:</td>
              <td><g:textField name="firstName" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="lastName"/>:</td>
              <td><g:textField name="lastName" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="country"/>:</td>
              <td><g:textField name="country" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="zip"/>:</td>
              <td><g:textField name="zip" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="city"/>:</td>
              <td><g:textField name="city" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="street"/>:</td>
              <td><g:textField name="street" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="phone"/>:</td>
              <td><g:textField name="phone" size="30"/></td>
            </tr>
            <tr>
              <td><g:message code="email"/>:</td>
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

    <div class="zusatz">
      <h5><g:message code="paten"/></h5>
      <div class="zusatz-show">
        <g:if test="${pates}">
          <ul>
            <g:each in="${pates}" var="pate">
              <li style="list-style-type: disc; margin-left: 15px"><g:link controller="pateProfile" action="show" id="${pate.id}" params="[entity: pate.id]">${pate.profile.fullName}</g:link></li>
            </g:each>
          </ul>
        </g:if>
        <g:else>
          <span class="italic"><g:message code="client.noPateYet"/></span>
        </g:else>
      </div>
    </div>

    <g:render template="/templates/links" model="[entity: client]"/>

  </div>
</div>
</body>
