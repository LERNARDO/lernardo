<%@ page import="at.uenterprise.erp.Setup; at.uenterprise.erp.base.Entity" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'client')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'client')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: client]"/>

    <g:form>
      <div>

        <table>

          <tr class="prop">
            <td class="name"><g:message code="gender"/></td>
            <td class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:client,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="firstName"/> <span class="required-indicator">*</span></td>
            <td class="value">
              <g:textField data-counter="${erp.getConstraintSizeMax(domainClass: 'ClientProfile', constraint: 'firstName')}" required="" class="${hasErrors(bean: client, field: 'profile.firstName', 'errors')}" size="40" name="firstName" value="${fieldValue(bean: client, field: 'profile.firstName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="lastName"/> <span class="required-indicator">*</span></td>
            <td class="value">
              <g:textField data-counter="50" class="${hasErrors(bean: client, field: 'profile.lastName', 'errors')}" required="" size="40" name="lastName" value="${fieldValue(bean: client, field: 'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="birthDate"/> <span class="required-indicator">*</span></td>
            <td class="value">
              <g:textField name="birthDate" class="datepicker-birthday ${hasErrors(bean: client, field: 'profile.birthDate', 'errors')}" required="" value="${formatDate(date: client?.profile?.birthDate, format: 'dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.interests"/></td>
            <td class="value">
              <g:textArea data-counter="2000" class="${hasErrors(bean: client, field: 'profile.interests', 'errors')}" rows="4" cols="50" name="interests" value="${fieldValue(bean: client, field: 'profile.interests').decodeHTML()}"/>
            </td>
          </tr>

        </table>

        <h4><g:message code="client.profile.curAddress"/></h4>

        <table>

          <tr class="prop">
            <td class="name"><g:message code="street"/></td>
            <td class="value">
              <g:textField data-counter="50" class="${hasErrors(bean: client, field: 'profile.currentStreet', 'errors')}" size="40" name="currentStreet" value="${fieldValue(bean: client, field: 'profile.currentStreet').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="groupColony"/></td>
            <td class="value">
              <g:select name="currentColony" from="${allColonies}" optionKey="id" optionValue="profile"/>
            </td>
          </tr>

        </table>

        <h4><g:message code="client.profile.origin"/></h4>

        <table>

          <tr class="prop">
            <td class="name"><g:message code="zip"/></td>
            <td class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.originZip', 'errors')}" size="10" name="originZip" value="${fieldValue(bean: client, field: 'profile.originZip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="city"/></td>
            <td class="value">
              <g:textField data-counter="50" class="${hasErrors(bean: client, field: 'profile.originCity', 'errors')}" size="30" name="originCity" value="${fieldValue(bean: client, field: 'profile.originCity').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="country"/></td>
            <td class="value">
              <g:textField data-counter="50" class="${hasErrors(bean: client, field: 'profile.originCountry', 'errors')}" size="30" name="originCountry" value="${fieldValue(bean: client, field: 'profile.originCountry').decodeHTML()}"/>
            </td>
          </tr>

        </table>

        <h4><g:message code="client.profile.more"/></h4>

        <table>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.familyStatus"/></td>
            <td class="value">
              <g:select name="familyStatus" from="${Setup.list()[0]?.familyStatus}" value="${client?.profile?.familyStatus}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="languages"/></td>
            <td class="value">
              <g:select name="languages" multiple="true" from="${Setup.list()[0]?.languages}" value="${client?.profile?.languages}" noSelection="['': message(code: 'none')]"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.school"/></td>
            <td class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.school', 'errors')}" size="20" name="school" value="${fieldValue(bean: client, field: 'profile.school').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.schoolLevel"/></td>
            <td class="value">
              <g:select name="schoolLevel" from="${Setup.list()[0]?.schoolLevels}" value="${client?.profile?.schoolLevel}" noSelection="['': message(code: 'none')]"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.job"/></td>
            <td class="value">
              <g:checkBox name="job" value="${client?.profile?.job}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.jobType"/></td>
            <td class="value">
              <g:select name="jobtypes" multiple="true" from="${Setup.list()[0]?.workDescriptions}" value="${client?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.jobIncome"/> (${grailsApplication.config.currency})</td>
            <td class="value">
              <g:textField size="10" name="jobIncome" value="${fieldValue(bean: client, field: 'profile.jobIncome')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.jobFrequency"/></td>
            <td class="value">
              <g:textField size="30" name="jobFrequency" value="${fieldValue(bean: client, field: 'profile.jobFrequency')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.support"/></td>
            <td class="value">
              <g:checkBox name="support" value="${client?.profile?.support}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="client.profile.supportDescription"/></td>
            <td class="value">
              <g:textField data-counter="500" class="${hasErrors(bean: client, field: 'profile.supportDescription', 'errors')}" size="30" name="supportDescription" value="${client?.profile?.supportDescription}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="citizenship"/></td>
            <td class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.citizenship', 'errors')}" size="15" name="citizenship" value="${fieldValue(bean: client, field: 'profile.citizenship')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="socialSecurityNumber"/></td>
            <td class="value">
              <g:textField class="${hasErrors(bean: client, field: 'profile.socialSecurityNumber', 'errors')}" size="30" name="socialSecurityNumber" value="${fieldValue(bean: client, field: 'profile.socialSecurityNumber')}"/>
            </td>
          </tr>

        </table>

        <div class="email">
          <table width="100%">
            <tr>
              <td valign="middle">
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${client?.user?.enabled}"/>
              </td>
              <td valign="middle">
                <g:message code="email"/> <span class="required-indicator">*</span>
                <g:textField class="${hasErrors(bean: client, field: 'user.email', 'errors')}" required="" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: client, field: 'user.email')}"/>
              </td>
            </tr>
          </table>
        </div>

      </div>
      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link></div>
      </div>
    </g:form>
  </div>
</div>
</body>
 