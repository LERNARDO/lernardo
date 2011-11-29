<head>
  <meta name="layout" content="database"/>
  <title><g:message code="educator"/> - ${educator.profile.fullName}</title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="educator"/> - ${educator.profile.fullName}</h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">

    <g:render template="/templates/educatorNavigation" model="[entity: entity]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="publication" action="list" id="${entity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${entity}"/></g:link></li>
        <li><g:link controller="msg" action="inbox" id="${entity.id}"><g:message code="privat.posts"/></g:link></li>
        <li><g:link controller="appointmentProfile" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="appointments"/></g:link></li>
        <li><g:link controller="evaluation" action="myevaluations" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.evaluation"/></g:link></li>
        <li><g:link style="border-right: none" controller="workdayUnit" action="index" id="${entity.id}" params="[entity:entity.id]"><g:message code="privat.workday"/></g:link></li>
      </ul>
    </div>

    <h4><g:message code="profile"/></h4>
    <table>
      <tbody>

      <tr class="prop">
        <td class="one"><g:message code="gender"/>:</td>
        <td class="two"><erp:showGender gender="${educator.profile.gender}"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="title"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.title') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="firstName"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.firstName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="lastName"/>:</td>
        <td class="two"><g:link action="show" id="${educator.id}" params="[entity:educator.id]">${educator.profile.lastName}</g:link></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="birthDate"/>:</td>
        <td class="two"><g:formatDate date="${educator.profile.birthDate}" format="dd. MM. yyyy"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.education"/>:</td>
        <td class="two">${educator.profile.education.decodeHTML() ?: '<div class="italic">' + message(code: "noData") + '</div>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.employment"/>:</td>
        <td class="two">${educator.profile.employment.decodeHTML() ?: '<div class="italic">' + message(code: "noData") + '</div>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.enlisted"/>:</td>
        <td class="two">${fieldValue(bean: enlistedBy, field: 'profile.fullName') ?: message(code: 'no')}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.interests"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.interests') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.inChargeOf"/>:</td>
        <td class="two">
          <g:if test="${educator.profile.inChargeOf}">
            <ul>
              <g:each in="${educator.profile.inChargeOf}" var="inchargeof">
                <li>${inchargeof}</li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
        </td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="educator.profile.languages"/>:</td>
        <td class="two">
          <g:if test="${educator.profile.languages}">
            <ul>
              <g:each in="${educator.profile.languages}" var="language">
                <li>${language}</li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
        </td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="bloodType"/>:</td>
        <td class="two">${fieldValue(bean: educator, field: 'profile.bloodType') ?: '<div class="italic">' + message(code: 'none') + '</div>'}</td>
      </tr>

      </tbody>
    </table>

    <h4><g:message code="educator.profile.curAddress"/></h4>
    <table style="width: 100%">

      <tr>
        <td valign="top" class="name-show"><g:message code="street"/></td>
        <td valign="top" class="name-show"><g:message code="zip"/></td>
        <td valign="top" class="name-show"><g:message code="city"/></td>
        <td valign="top" class="name-show"><g:message code="country"/></td>
      </tr>

      <tr>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.currentStreet') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.currentZip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.currentCity') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.currentCountry') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
      </tr>

    </table>

    <h4><g:message code="educator.profile.origin"/></h4>
    <table style="width: 100%">

      <tr>
        <td valign="top" class="name-show"><g:message code="street"/></td>
        <td valign="top" class="name-show"><g:message code="zip"/></td>
        <td valign="top" class="name-show"><g:message code="city"/></td>
        <td valign="top" class="name-show"><g:message code="country"/></td>
      </tr>

      <tr>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.originStreet') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.originZip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.originCity') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.originCountry') ?: '<span class="italic">' + message(code: 'unknown') + '</span>'}
        </td>
      </tr>

    </table>

    <h4><g:message code="educator.profile.emContact"/></h4>
    <table style="width: 100%">

      <tr>
        <td valign="top" class="name-show"><g:message code="name"/></td>
        <td valign="top" class="name-show"><g:message code="street"/></td>
        <td valign="top" class="name-show"><g:message code="zip"/></td>
        <td valign="top" class="name-show"><g:message code="city"/></td>
      </tr>

      <tr>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.contactName') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.contactStreet') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.contactZip') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.contactCity') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>

      </tr>

      <tr>
        <td valign="top" class="name-show"><g:message code="country"/></td>
        <td valign="top" class="name-show"><g:message code="phone"/></td>
        <td colspan="2" valign="top" class="name-show"><g:message code="email"/></td>
      </tr>

      <tr>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.contactCountry') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.contactPhone') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
        <td valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.contactMail') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
      </tr>

      <tr>
        <td valign="top" class="name-show"><g:message code="phone"/> #1</td>
        <td valign="top" class="name-show"><g:message code="phone"/> #2</td>
        <td colspan="2" valign="top" class="name-show"><g:message code="educator.profile.privMail"/></td>
      </tr>

      <tr>
        <td width="280" height="25" valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.phone1') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
        <td width="280" height="25" valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.phone2') ?: '<span class="italic">' + message(code: 'noData') + '</span>'}
        </td>
        <td width="105" valign="top" class="value-show">
          ${fieldValue(bean: educator, field: 'profile.privEmail') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}
        </td>
      </tr>

    </table>

    <div class="email">
      <table style="width: 100%">

        <tr>
          <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
            <td>
              <span class="bold"><g:message code="active"/> </span>
              <g:formatBoolean boolean="${educator.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
            </td>
          </erp:accessCheck>
          <td>
            <span class="bold"><g:message code="email"/>: </span>
            ${fieldValue(bean: educator, field: 'user.email') ?: '<div class="italic">' + message(code: 'empty') + '</div>'}
          </td>
          <td>
            <span class="bold"><g:message code="languageSelection"/>:</span>
            ${educator?.user?.locale?.getDisplayLanguage()}
          </td>
          <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${educator}">
            <td>
              <g:form controller="profile" action="changePassword" id="${educator.id}">
                <span class="bold"><g:message code="password"/>: </span>
                <g:submitButton name="submit" value="${message(code: 'change')}"/>
                <div class="clear"></div>
              </g:form>
            </td>
          </erp:accessCheck>
        </tr>

      </table>
    </div>

    <div class="zusatz">
      <h5><g:message code="educator.profile.inOut" args="[grailsApplication.config.customerName]"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#dates');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="dates" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'educatorProfile', action:'addDate', id:educator.id]" update="dates2" before="showspinner('#dates2');" after="toggle('#dates');">
            <g:textField name="date" size="12" class="datepicker" value=""/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
          </g:formRemote>
        </div>

      <div class="zusatz-show" id="dates2">
        <g:render template="dates" model="[educator: educator, entity: currentEntity]"/>
      </div>
    </div>

    <g:render template="/templates/links" model="[entity: educator]"/>

  </div>
</div>
</body>
