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
    <div>

      <table>
        
        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="educator.profile.gender"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.title"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.firstName"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.lastName"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.birthDate"/></td>
        </tr>

        <tr>
          <td width="90" valign="top" class="value-show">
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
            %{--
            <g:formatDate date="${educator.profile.birthDate}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
            --}%
            <g:formatDate date="${educator.profile.birthDate}" format="dd. MM. yyyy" />
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
          <td width="260" valign="top" class="value-show">
            <g:if test="${educator.profile.education}">
              ${educator.profile.education}
            </g:if>
            <g:else>
              <div class="italic"><g:message code="noData"/></div>  
            </g:else>
          </td>
          <td width="260" valign="top" class="value-show">
            ${educator.profile.employment}
          </td>
          <td width="220" valign="top" class="value-show">
            <g:if test="${grailsApplication.config.educatorProfile.enlisted}">
              ${fieldValue(bean: enlistedBy, field: 'profile.fullName') ?: '<div class="italic">'+message(code:'no')+'</div>'}
            </g:if>
          </td>
        </tr>

      </table>

      <table>

        <tr>
          <td valign="top" class="name-show"><g:message code="educator.profile.interests"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.inChargeOf"/></td>
          <td valign="top" class="name-show"><g:message code="educator.profile.languages"/></td>
        </tr>

        <tr>
          <td height="60" width="260" valign="top" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.interests') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
          <td width="260" valign="top" class="value-show-block">
            <g:if test="${educator.profile.inChargeOf}">
              <ul>
                <g:each in="${educator.profile.inChargeOf}" var="inchargeof">
                  <li>${inchargeof}</li>
                </g:each>
              </ul>
            </g:if>
            <g:else>
              <div class="italic">${message(code:'noData')}</div>
            </g:else>
          </td>
          <td width="220" valign="top" class="value-show-block">
            <g:if test="${educator.profile.languages}">
              <ul>
                <g:each in="${educator.profile.languages}" var="language">
                  <li>${language}</li>
                </g:each>
              </ul>
            </g:if>
            <g:else>
              <div class="italic">${message(code:'noData')}</div>
            </g:else>
          </td>
        </tr>

      </table>

      <h4><g:message code="educator.profile.curAddress"/></h4>
      <div>
        <table>

          <tr>
            <td valign="top" class="name-show"><g:message code="educator.profile.currentStreet"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.currentZip"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.currentCity"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.currentCountry"/></td>
          </tr>

          <tr>
            <td width="280" valign="top" class="value-show">
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
      <div>
        <table>

          <tr>
            <td valign="top" class="name-show"><g:message code="educator.profile.originStreet"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.originZip"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.originCity"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.originCountry"/></td>
          </tr>

          <tr>
            <td width="280" valign="top" class="value-show">
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
                ${educator.profile.originCountry}
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
      <div>
        <table>

          <tr>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactName"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactStreet"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactZip"/></td>
            <td valign="top" class="name-show"><g:message code="educator.profile.contactCity"/></td>
          </tr>

          <tr>
            <td width="280" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactName') ?: '<span class="italic">'+message(code:'noData')+'</span>'}
            </td>
            <td width="280" valign="top" class="value-show">
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
            <td width="120" valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.contactCountry') ?: '<div class="italic">'+message(code:'empty')+'</div>'}
            </td>
            <td width="270" valign="top" class="value-show">
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
        <div>
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

      <div>
        <table>
          <tr>
            <td valign="top" class="name-show"><g:message code="bloodType"/></td>
          </tr>
          <tr>
            <td valign="top" class="value-show">
              ${fieldValue(bean: educator, field: 'profile.bloodType') ?: '<div class="italic">'+message(code:'none')+'</div>'}
            </td>
          </tr>
        </table>
      </div>

      <div class="email">
        <table>

          <tr>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
              <td width="100" valign="middle">
                <span class="bold"><g:message code="active"/></span>
                <g:formatBoolean boolean="${educator.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
            </erp:accessCheck>

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
      <g:form id="${educator.id}" params="[entity: educator?.id]">
        <erp:isMeOrAdminOrOperator entity="${educator}" current="${currentEntity}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        </erp:isMeOrAdminOrOperator>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: educator.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="educator.profile.inOut" args="[grailsApplication.config.projectName]"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#dates'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="dates" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'educatorProfile', action:'addDate', id:educator.id]" update="dates2" before="showspinner('#dates2');" after="toggle('#dates');">
          <g:datePicker name="date" value="" precision="day"/>
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
