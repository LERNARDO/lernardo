<head>
  <meta name="layout" content="private"/>
  <title><g:message code="client.profile.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="client.profile.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: client]"/>

    <g:form action="update" id="${client.id}">
      <div>

        <table>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="client.profile.gender"/></td>
            <td valign="top" class="name"><g:message code="client.profile.firstName"/></td>
            <td valign="top" class="name"><g:message code="client.profile.lastName"/></td>
            <td valign="top" class="name"><g:message code="client.profile.birthDate"/></td>
          </tr>

          <tr>
            <td width="120" valign="top" class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:client,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
            <td width="200" valign="top" class="value ${hasErrors(bean: client, field: 'profile.firstName', 'errors')}">
              <g:textField class="countable${client.profile.constraints.firstName.maxSize}" size="25" name="firstName" value="${fieldValue(bean: client, field: 'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="270" valign="top" class="value ${hasErrors(bean: client, field: 'profile.lastName', 'errors')}">
              <g:textField class="countable${client.profile.constraints.lastName.maxSize}" size="38" name="lastName" value="${fieldValue(bean: client, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td height="35" valign="top" class="value ${hasErrors(bean: client, field: 'profile.birthDate', 'errors')}">
              <g:textField name="birthDate" size="30" class="datepicker-birthday" value="${client?.profile?.birthDate?.format('dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr>
            <td valign="top" class="name"><g:if test="${grailsApplication.config.clientProfile.size}"><g:message code="client.profile.size"/></g:if></td>
            <td valign="top" class="name"><g:if test="${grailsApplication.config.clientProfile.weight}"><g:message code="client.profile.weight"/></g:if></td>
            <td colspan="2" valign="top" class="name"><g:message code="client.profile.interests"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:if test="${grailsApplication.config.clientProfile.size}">
                <g:select from="${100..250}" name="size" value="${fieldValue(bean: client, field: 'profile.size')}" noSelection="['': message(code: 'unknown')]"/> (cm)
              </g:if>
            </td>
            <td valign="top" class="value">
              <g:if test="${grailsApplication.config.clientProfile.weight}">
                <g:select from="${10..150}" name="weight" value="${fieldValue(bean: client, field: 'profile.weight')}" noSelection="['': message(code: 'unknown')]"/> (kg)
              </g:if>
            </td>
            <td colspan="2" valign="top" class="value">
              <g:textArea class="countable${client.profile.constraints.interests.maxSize} ${hasErrors(bean: client, field: 'profile.interests', 'errors')}" rows="1" cols="75" name="interests" value="${fieldValue(bean: client, field: 'profile.interests').decodeHTML()}"/>
            </td>
          </tr>

        </table>

        <h4><g:message code="client.profile.curAddress"/></h4>
        <div>
          <table>

            <tr>
              <td valign="top" class="name"><g:message code="client.profile.currentStreet"/></td>
              <td valign="top" class="name"><g:message code="client.profile.currentZip"/></td>
              <td valign="top" class="name"><g:message code="client.profile.currentColonia"/></td>
              <td valign="top" class="name"><g:message code="client.profile.currentCountry"/></td>
            </tr>

            <tr>
              <td width="280" height="35" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.currentStreet.maxSize} ${hasErrors(bean: client, field: 'profile.currentStreet', 'errors')}" size="41" name="currentStreet" value="${fieldValue(bean: client, field: 'profile.currentStreet').decodeHTML()}"/>
              </td>
              <td width="105" valign="top" class="value">
                <g:textField class="${hasErrors(bean: client, field: 'profile.currentZip', 'errors')}" size="12" name="currentZip" value="${fieldValue(bean: client, field: 'profile.currentZip').decodeHTML()}"/>
              </td>
              <td width="210" valign="top" class="value">
                <g:select name="currentColonia" from="${allColonies}" value="${colonia.id}" optionKey="id" optionValue="profile"/>
              </td>
              <td valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.currentCountry.maxSize} ${hasErrors(bean: client, field: 'profile.currentCountry', 'errors')}" size="30" name="currentCountry" value="${fieldValue(bean: client, field: 'profile.currentCountry').decodeHTML()}"/>
              </td>
            </tr>
          </table>
        </div>

        <h4><g:message code="client.profile.origin"/></h4>
        <div>
          <table>

            <tr>
              <td valign="top" class="name"><g:if test="${grailsApplication.config.clientProfile.originZip}"><g:message code="client.profile.originZip"/></g:if></td>
              <td valign="top" class="name"><g:if test="${grailsApplication.config.clientProfile.originCity}"><g:message code="client.profile.originCity"/></g:if></td>
              <td colspan="2" valign="top" class="name"><g:message code="client.profile.originCountry"/></td>
            </tr>

            <tr>
              <td width="105" valign="top" class="value">
                <g:if test="${grailsApplication.config.clientProfile.originZip}">
                  <g:textField class="${hasErrors(bean: client, field: 'profile.originZip', 'errors')}" size="12" name="originZip" value="${fieldValue(bean: client, field: 'profile.originZip').decodeHTML()}"/>
                </g:if>
              </td>
              <td width="210" valign="top" class="value">
                <g:if test="${grailsApplication.config.clientProfile.originCity}">
                  <g:textField class="countable${client.profile.constraints.originCity.maxSize} ${hasErrors(bean: client, field: 'profile.originCity', 'errors')}" size="30" name="originCity" value="${fieldValue(bean: client, field: 'profile.originCity').decodeHTML()}"/>
                </g:if>
              </td>
              <td valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.originCountry.maxSize} ${hasErrors(bean: client, field: 'profile.originCountry', 'errors')}" size="30" name="originCountry" value="${fieldValue(bean: client, field: 'profile.originCountry').decodeHTML()}"/>
              </td>
            </tr>
          </table>
        </div>

        <h4><g:message code="client.profile.more"/></h4>
        <div>
          <table>

            <tr class="prop">
              <td valign="top" class="name"><g:if test="${grailsApplication.config.clientProfile.familyStatus}"><g:message code="client.profile.familyStatus"/></g:if></td>
              <td valign="top" class="name"><g:message code="client.profile.languages"/></td>
              <td valign="top" class="name"><g:message code="client.profile.school"/></td>
              <td valign="top" class="name"><g:message code="client.profile.schoolLevel"/></td>
            </tr>

            <tr>
              <td width="160px" valign="top" class="value">
                <g:if test="${grailsApplication.config.clientProfile.familyStatus}">
                  <g:select class="drop-down-150" name="familyStatus" from="${grailsApplication.config.familyrelations}" value="${client?.profile?.familyStatus}" valueMessagePrefix="familyrelation"/>
                </g:if>
              </td>
              <td width="250" valign="top" class="value">
                <g:select class="liste-210" name="languages" multiple="true" from="${grailsApplication.config.languages}" value="${client?.profile?.languages}" noSelection="['': message(code: 'none')]" valueMessagePrefix="language"/>
              </td>
              <td width="230" valign="top" class="value">
                <g:select class="drop-down-200" name="school" from="${allFacilities}" value="${school.id}" optionKey="id" optionValue="profile"/>
              </td>
              <td width="210" valign="top" class="value">
                <g:select class="drop-down-205" name="schoolLevel" from="${grailsApplication.config.schoollevels}" value="${client?.profile?.schoolLevel}" noSelection="['': message(code: 'none')]" valueMessagePrefix="schoollevel"/>
              </td>
            </tr>

            <g:if test="${grailsApplication.config.project == 'sueninos'}">
            <tr class="prop">
              <td></td>
              <td valign="top" class="name"><g:message code="client.profile.schoolDropoutDate"/></td>
              <td colspan="2" valign="top" class="name"><g:message code="client.profile.schoolDropoutReason"/></td>
            </tr>

            <tr>
              <td valign="top" class="value">
                <g:message code="client.profile.schoolDropout"/>
                <g:checkBox name="schoolDropout" value="${client?.profile?.schoolDropout}"/>
              </td>
              <td valign="top" class="value">
                <g:textField name="schoolDropoutDate" size="30" class="datepicker-birthday" value="${client?.profile?.schoolDropoutDate?.format('dd. MM. yyyy')}"/>
              </td>
              <td colspan="2" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.schoolDropoutReason.maxSize} ${hasErrors(bean: client, field: 'profile.schoolDropoutReason', 'errors')}" size="64" name="schoolDropoutReason" value="${fieldValue(bean: client, field: 'profile.schoolDropoutReason').decodeHTML()}"/>
              </td>
            </tr>
            </g:if>

            <g:if test="${grailsApplication.config.project == 'sueninos'}">
            <tr class="prop">
              <td></td>
              <td valign="top" class="name"><g:message code="client.profile.schoolRestartDate"/></td>
              <td colspan="2" valign="top" class="name"><g:message code="client.profile.schoolRestartReason"/></td>
            </tr>

            <tr>
              <td valign="top" class="value">
                <g:message code="client.profile.schoolRestart"/>
                <g:checkBox name="schoolRestart" value="${client?.profile?.schoolRestart}"/>
              </td>
              <td valign="top" class="value">
                <g:textField name="schoolRestartDate" size="30" class="datepicker-birthday" value="${client?.profile?.schoolRestartDate?.format('dd. MM. yyyy')}"/>
              </td>
              <td colspan="2" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.schoolRestartReason.maxSize} ${hasErrors(bean: client, field: 'profile.schoolRestartReason', 'errors')}" size="64" name="schoolRestartReason" value="${fieldValue(bean: client, field: 'profile.schoolRestartReason').decodeHTML()}"/>
              </td>
            </tr>

            <tr>
              <td colspan="4">&nbsp;</td>
            </tr>
            </g:if>

            <g:if test="${grailsApplication.config.project == 'sueninos'}">
            <tr class="prop">
              <td></td>
              <td><g:message code="client.profile.jobType"/></td>
              <td><g:message code="client.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
              <td><g:message code="client.profile.jobFrequency"/></td>
            </tr>

            <tr>
              <td valign="top" class="value ${hasErrors(bean: client, field: 'profile.job', 'errors')}">
                <g:message code="client.profile.job"/>
                <g:checkBox name="job" value="${client?.profile?.job}"/>
              </td>
              <td height="35" valign="top" class="value ${hasErrors(bean: client, field: 'profile.jobType', 'errors')}">
                <g:select name="jobtypes" multiple="true" from="${grailsApplication.config.jobs}" value="${client?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]" valueMessagePrefix="job"/>
              </td>
              <td valign="top" class="value ${hasErrors(bean: client, field: 'profile.jobIncome', 'errors')}">
                <g:textField size="30" name="jobIncome" value="${fieldValue(bean: client, field: 'profile.jobIncome')}"/>
              </td>
              <td valign="top" class="value ${hasErrors(bean: client, field: 'profile.jobFrequency', 'errors')}">
                <g:textField size="28" name="jobFrequency" value="${fieldValue(bean: client, field: 'profile.jobFrequency')}"/>
              </td>
            </tr>
            </g:if>

            <tr class="prop">
              <td></td>
              <td colspan="3" valign="top" class="name"><g:message code="client.profile.supportDescription"/></td>
            </tr>

            <tr>
              <td valign="top" class="value">
                <g:message code="client.profile.support"/>
                <g:checkBox name="support" value="${client?.profile?.support}"/>
              </td>
              <td colspan="3" valign="top" class="value">
                <g:textField class="countable${client.profile.constraints.supportDescription.maxSize} ${hasErrors(bean: client, field: 'profile.supportDescription', 'errors')}" size="30" name="supportDescription" value="${client?.profile?.supportDescription}"/>
              </td>
            </tr>

            <tr>
              <td valign="top" class="name"><g:if test="${grailsApplication.config.clientProfile.citizenship}">Staatsbürgerschaft</g:if></td>
              <td colspan="3" valign="top" class="name"><g:if test="${grailsApplication.config.clientProfile.socialSecurityNumber}">Sozialversicherungsnummer</g:if></td>
            <tr>

            <tr>
              <td width="210" valign="top" class="value">
                <g:if test="${grailsApplication.config.clientProfile.citizenship}">
                  <g:textField class="${hasErrors(bean: client, field: 'profile.citizenship', 'errors')}" size="10" name="citizenship" value="${fieldValue(bean: client, field: 'profile.citizenship')}"/>
                </g:if>
              </td>
              <td  colspan="3" valign="top" class="value">
                <g:if test="${grailsApplication.config.clientProfile.socialSecurityNumber}">
                  <g:textField class="${hasErrors(bean: client, field: 'profile.socialSecurityNumber', 'errors')}" size="30" name="socialSecurityNumber" value="${fieldValue(bean: client, field: 'profile.socialSecurityNumber')}"/>
                </g:if>
              </td>
            </tr>

            %{--<g:if test="${grailsApplication.config.clientProfile.contact}">

              <tr>
                <td colspan="4">Kontakt im Notfall</td>
              </tr>

              <tr>
                <td valign="top" class="name">Name:</td>
                <td valign="top" class="name">Land:</td>
                <td valign="top" class="name">PLZ:</td>
                <td valign="top" class="name">Stadt:</td>
              <tr>

              <tr>
                <td valign="top" class="value">
                  <g:textField class="${hasErrors(bean: client, field: 'profile.contactName', 'errors')}" size="20" name="contactName" value="${fieldValue(bean: client, field: 'profile.contactName')}"/>
                </td>
                <td valign="top" class="value">
                  <g:textField class="${hasErrors(bean: client, field: 'profile.contactCountry', 'errors')}" size="20" name="contactCountry" value="${fieldValue(bean: client, field: 'profile.contactCountry')}"/>
                </td>
                <td valign="top" class="value">
                  <g:textField class="${hasErrors(bean: client, field: 'profile.contactZip', 'errors')}" size="20" name="contactZip" value="${fieldValue(bean: client, field: 'profile.contactZip')}"/>
                </td>
                <td valign="top" class="value">
                  <g:textField class="${hasErrors(bean: client, field: 'profile.contactCity', 'errors')}" size="20" name="contactCity" value="${fieldValue(bean: client, field: 'profile.contactCity')}"/>
                </td>
              </tr>

              <tr>
                <td valign="top" class="name">Straße:</td>
                <td valign="top" class="name">Telefon:</td>
                <td colspan="2" valign="top" class="name">E-Mail:</td>
              <tr>

              <tr>
                <td valign="top" class="value">
                  <g:textField class="${hasErrors(bean: client, field: 'profile.contactStreet', 'errors')}" size="20" name="contactStreet" value="${fieldValue(bean: client, field: 'profile.contactStreet')}"/>
                </td>
                <td valign="top" class="value">
                  <g:textField class="${hasErrors(bean: client, field: 'profile.contactPhone', 'errors')}" size="20" name="contactPhone" value="${fieldValue(bean: client, field: 'profile.contactPhone')}"/>
                </td>
                <td valign="top" class="value">
                  <g:textField colspan="2" class="${hasErrors(bean: client, field: 'profile.contactMail', 'errors')}" size="20" name="contactMail" value="${fieldValue(bean: client, field: 'profile.contactMail')}"/>
                </td>
              </tr>
            </g:if>--}%

          </table>
        </div>

        <div class="email">
          <table>
            <tr>
              <erp:isOperator entity="${currentEntity}">
                <td width="90" valign="top">
                  <g:message code="active"/>
                </td>
                <td width="30">
                  <g:checkBox name="enabled" value="${client?.user?.enabled}"/>
                </td>
              </erp:isOperator>
              <td width="85" valign="top">
                <g:message code="client.profile.email"/>:
              </td>
              <td width="290" valign="top">
                <g:textField class="${hasErrors(bean: client, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: client, field: 'user.email')}"/>
              </td>
              <td width="140" valign="top">
                <g:message code="languageSelection"/>:
              </td>
              <td valign="top">
                <erp:localeSelect class="drop-down-150" name="locale" value="${client?.user?.locale}"/>
              </td>
            </tr>
            <tr>
              <td valign="top">
                <g:message code="showTips"/>
              </td>
              <td>
                <g:checkBox name="showTips" value="${client?.profile?.showTips}"/>
              </td>
              <td valign="top" class="name">
                <g:message code="password"/>:
              </td>
              <td valign="top" class="value">
                <g:link controller="profile" action="changePassword" id="${client.id}"><g:message code="change"/></g:link>
              </td>
            </tr>
          </table>
        </div>

      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <erp:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${client.id}" onclick="${erp.getLinks(id: client.id)}"><g:message code="delete"/></g:link>
        </erp:isOperator>
        <g:link class="buttonGray" action="show" id="${client.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>