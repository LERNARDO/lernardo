<head>
  <meta name="layout" content="private"/>
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
    <div class="dialog">

      <table>
        
        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="educator.profile.gender"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.title"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.firstName"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.lastName"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.birthDate"/></td>
        </tr>

        <tr>
          <td width="90" height="25" valign="top" class="value-show">
            <erp:showGender gender="${educator.profile.gender}"/>
          </td>
          <td width="120" valign="top" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.title') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
          <td width="180" valign="top" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.firstName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
          <td width="210" valign="top" class="value-show">
            <g:link action="show" id="${educator.id}" params="[entity:educator.id]">${educator.profile.lastName}</g:link>
          </td>
          <td valign="top" class="value-show">
            <g:formatDate date="${educator.profile.birthDate}" format="dd. MM. yyyy"/>
          </td>
        </tr>

      </table>

      <table>

        <tr>
          <td class="name-show"><g:message code="educator.profile.education"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.employment"/></td>
          <td valign="top" class="name-show"><g:if test="${grailsApplication.config.educatorProfile.enlisted}"><g:message code="educator.profile.enlisted"/></g:if></td>
        </tr>

        <tr>
          <td width="280" height="25" valign="top" class="value-show">
            <g:if test="${educator.profile.education}">
              <g:message code="education.${educator.profile.education}"/>
            </g:if>
            <g:else>
              <div class="italic"><g:message code="noData"/></div>  
            </g:else>
          </td>
          <td width="280" valign="top" class="value-show">
            <g:message code="employment.${educator.profile.employment}"/>
          </td>
          <td valign="top" class="value-show">
            <g:if test="${grailsApplication.config.educatorProfile.enlisted}">
              ${fieldValue(bean: enlistedBy, field: 'profile.fullName') ?: '<div class="italic">'+message(code:'no')+'</div>'}
            </g:if>
          </td>
        </tr>

        <tr>
          <td valign="top" class="name-show"><g:message code="educator.profile.interests"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.inChargeOf"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.languages"/></td>
        </tr>

        <tr>
          <td height="60" valign="top" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.interests') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
          <td valign="top" class="value-show-block">
            <g:if test="${educator.profile.inChargeOf}">
            <ul>
              <g:each in="${educator.profile.inChargeOf}" var="inchargeof">
                <li><g:message code="inchargeof.${inchargeof}"/></li>
              </g:each>
            </ul>
            </g:if>
            <g:else>
              <div class="italic">${message(code:'noData')}</div>
            </g:else>
          </td>
          <td valign="top" class="value-show-block">
            <ul>
              <g:each in="${educator.profile.languages}" var="language">
                <li><g:message code="language.${language}"/></li>
              </g:each>
            </ul>
          </td>
        </tr>

        <erp:isOperator entity="${currentEntity}">
          <tr class="prop">
            <td valign="top" class="name-show"><g:message code="educator.profile.workHours"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.hourlyWage"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.overtimePay"/></td>
          </tr>

          <tr>
            <td width="150" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.workHours') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="150" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.hourlyWage') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="150" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.overtimePay') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
          </tr>
        </erp:isOperator>

        %{--<tr>
        <td colspan="3" valign="top" class="name-show">
        <g:message code="educator.profile.colonia"/>:
        </td>
          </tr>

        <tr>
        <td  valign="top" class="value-show">
        <g:if test="${colony}"><g:link controller="groupColonyProfile" action="show" id="${colony.id}">${colony.profile.fullName}</g:link></g:if><g:else><span class="italic red"><g:message code="educator.profile.colonia.empty"/> <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span></g:else>
        </td>
        <td colspan="3" valign="top" >
        </td>
        </tr>--}%

      </table>

      <h4><g:message code="educator.profile.curAddress"/></h4>
      <div class="contact">
        <table>

          <tr>
            <td valign="top" class="name-show"><g:message code="educator.profile.currentStreet"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.currentZip"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.currentCity"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.currentCountry"/></td>
          </tr>

          <tr>
            <td width="280" height="25" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.currentStreet') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="105" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.currentZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="210" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.currentCity') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="110" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.currentCountry') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
          </tr>

        </table>
      </div>

      <g:if test="${grailsApplication.config.educatorProfile.origin}">
      <h4><g:message code="educator.profile.origin"/></h4>
      <div class="contact">
        <table>

          <tr>
            <td valign="top" class="name-show"><g:message code="educator.profile.originStreet"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.originZip"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.originCity"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.originCountry"/></td>
          </tr>

          <tr>
            <td width="280" height="25" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.originStreet') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="105" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.originZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="210" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.originCity') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="110" valign="top" class="value-show">
              <g:if test="${educator.profile.originCountry}">
                <g:message code="nationality.${educator.profile.originCountry}"/>
              </g:if>
              <g:else>
                 <div class="italic"><g:message code="unknown"/></div>
              </g:else>
            </td>

          </tr>

        </table>
      </div>
      </g:if>

      <g:if test="${grailsApplication.config.educatorProfile.contact}">
      <h4><g:message code="educator.profile.emContact"/></h4>
      <div class="contact">
        <table>

          <tr>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactName"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactStreet"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactZip"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactCity"/></td>
          </tr>

          <tr>
            <td width="280" height="25" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="280" height="25" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactStreet') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="105" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactZip') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="210" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactCity') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>

          </tr>

        </table>

        <table>

          <tr>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactCountry"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactPhone"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactMail"/></td>
          </tr>

          <tr>
            <td width="110" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactCountry') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="280" height="25" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactPhone') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="340" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactMail') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
          </tr>

        </table>
      </div>
      </g:if>

      <g:if test="${grailsApplication.config.educatorProfile.phone}">
        <div class="contact">
          <table>

            <tr>
              <td valign="top" class="name-show">Telefon #1</td>
              <td valign="top" class="name-show">Telefon #2</td>
              <td valign="top" class="name-show">Private E-Mail</td>
            </tr>

            <tr>
              <td width="280" height="25" valign="top" class="value-show">
                ${fieldValue(bean: educator, field: 'profile.phone1') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
              </td>
              <td width="280" height="25" valign="top" class="value-show">
                ${fieldValue(bean: educator, field: 'profile.phone2') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
              </td>
              <td width="105" valign="top" class="value-show">
                ${fieldValue(bean: educator, field: 'profile.privEmail') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
              </td>
            </tr>

          </table>
        </div>
      </g:if>

      <div class="email">
        <table>

          <tr>
            <erp:isOperator entity="${currentEntity}">
              <td width="100" valign="middle">
                <span class="bold"><g:message code="active"/></span>
                <g:formatBoolean boolean="${educator.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:isOperator>

            <td width="280" valign="middle">
              <span class="bold"><g:message code="educator.profile.email"/>:</span>
              ${fieldValue(bean: educator, field: 'user.email') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td valign="middle">
              <span class="bold"><g:message code="languageSelection"/>:</span>
              ${educator?.user?.locale?.getDisplayLanguage()}
            </td>
          </tr>

        </table>
      </div>
    </div>

    <div class="buttons">
      <erp:isMeOrAdminOrOperator entity="${educator}" current="${currentEntity}">
        <g:link class="buttonGreen" action="edit" id="${educator?.id}"><g:message code="edit"/></g:link>
      </erp:isMeOrAdminOrOperator>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="educator.profile.inOut" args="[grailsApplication.config.projectName]"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" me="false"><a onclick="toggle('#dates'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Datum hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="dates" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'educatorProfile', action:'addDate', id:educator.id]" update="dates2" before="showspinner('#dates2')">
          <g:datePicker name="date" value="" precision="day"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
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
