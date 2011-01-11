<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="parent.profile.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="parent.profile.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: parent]"/>

    <g:form action="update" id="${parent.id}">
      <div class="dialog">

        <table width="100%" bgcolor="#dfdfdf" border="0" cellspacing="10">
          <tbody>

          <tr>
            <td width="90" valign="middle" class="name"><g:message code="parent.profile.gender"/>:</td>
            <td width="120" valign="middle" class="name"><g:message code="parent.profile.firstName"/>:</td>
            <td width="180" valign="middle" class="name"><g:message code="parent.profile.lastName"/>:</td>
            <td width="210" valign="middle" class="name"><g:message code="parent.profile.birthDate"/>:</td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:parent,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="countable${parent.profile.constraints.firstName.maxSize} ${hasErrors(bean:parent,field:'profile.firstName','errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean:parent,field:'profile.firstName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="countable${parent.profile.constraints.lastName.maxSize} ${hasErrors(bean: parent, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: parent, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField name="birthDate" size="30" class="datepicker-birthday" value="${parent?.profile?.birthDate?.format('dd. MM. yyyy')}"/>
              %{--<g:datePicker name="birthDate" value="${parent?.profile?.birthDate}" precision="day" years="${new Date().getYear()+1800..new Date().getYear()+1900}"/>--}%
            </td>
          </tr>

          <tr>
            <td valign="middle" class="name"><g:message code="parent.profile.maritalStatus"/>:</td>
            <td valign="middle" class="name"><g:message code="parent.profile.languages"/>:</td>
            <td valign="middle" class="name"><g:message code="parent.profile.description"/>:</td>
            <td valign="middle" class="name"><g:if test="${grailsApplication.config.parentProfile.education}"><g:message code="parent.profile.education"/>:</g:if></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:select class="drop-down-200" name="maritalStatus" from="${grailsApplication.config.maritalstatus}" value="${parent?.profile?.maritalStatus}" valueMessagePrefix="maritalstatus"/>
            </td>
            <td valign="top" class="value">
              <g:select class="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages}" value="${parent?.profile?.languages}" noSelection="['': message(code: 'none')]" valueMessagePrefix="language"/>
            </td>
            <td valign="top" class="value">
              <g:textArea class="countable${parent.profile.constraints.comment.maxSize}" name="comment" rows="3" cols="27" value="${fieldValue(bean: parent, field: 'profile.comment')}"/>
            </td>
            <td valign="top" class="value">
              <g:if test="${grailsApplication.config.parentProfile.education}">
                <g:select class="drop-down-205" name="education" from="${grailsApplication.config.schoollevels}" value="${parent?.profile?.education}" noSelection="['': message(code: 'none')]" valueMessagePrefix="schoollevel"/>
              </g:if>
            </td>
          </tr>

          <tr>
            <td valign="middle" class="name">&nbsp;</td>
            <td valign="middle" class="name"><g:message code="parent.profile.jobType"/>:</td>
            <td valign="middle" class="name"><g:if test="${grailsApplication.config.parentProfile.jobIncome}"><g:message code="parent.profile.jobIncome"/> (${grailsApplication.config.currency}):</g:if></td>
            <td valign="middle" class="name"><g:if test="${grailsApplication.config.parentProfile.jobFrequency}"><g:message code="parent.profile.jobFrequency"/>:</g:if></td>
          </tr>

          <tr>
            <td valign="top" class="value-comb"><g:message code="parent.profile.job"/>:
              <g:checkBox name="job" value="${parent?.profile?.job}"/>
            </td>
            <td valign="top" class="value">
              <g:if test="${grailsApplication.config.project == 'noe'}">
                <g:select name="jobtypes" from="${grailsApplication.config.jobs}" optionKey="key" optionValue="value" value="${parent?.profile?.jobtypes}"/>
              </g:if>
              <g:if test="${grailsApplication.config.project == 'sueninos'}">
                <g:select name="jobtypes" multiple="true" from="${grailsApplication.config.jobs}" value="${parent?.profile?.jobtypes}" noSelection="['': message(code: 'unknown')]" valueMessagePrefix="job"/>
              </g:if>
            </td>
            <td valign="top" class="value">
              <g:if test="${grailsApplication.config.parentProfile.jobIncome}">
                <g:textField class="${hasErrors(bean: parent, field: 'profile.jobIncome', 'errors')}" size="30" id="jobIncome" name="jobIncome" value="${parent?.profile?.jobIncome?.toInteger()}"/>
              </g:if>
            </td>
            <td valign="top" class="value">
              <g:if test="${grailsApplication.config.parentProfile.jobFrequency}">
                <g:textField class="${hasErrors(bean: parent, field: 'profile.jobFrequency', 'errors')}" size="30" id="jobFrequency" name="jobFrequency" value="${parent?.profile?.jobFrequency}"/>
              </g:if>
            </td>
          </tr>

          <tr>
            <td valign="top" class="name"><g:if test="${grailsApplication.config.parentProfile.currentCountry}"><g:message code="parent.profile.currentCountry"/></g:if></td>
            <td valign="top" class="name"><g:message code="parent.profile.currentCity"/></td>
            <td valign="top" class="name"><g:message code="parent.profile.currentStreet"/></td>
            <td valign="top" class="name"><g:message code="parent.profile.currentZip"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:if test="${grailsApplication.config.parentProfile.currentCountry}">
                <g:select name="currentCountry" from="${grailsApplication.config.nationalities}" value="${parent?.profile?.currentCountry}" noSelection="['': message(code: 'unknown')]" valueMessagePrefix="nationality"/>
              </g:if>
            </td>
            <td width="105" valign="top" class="value">
              <g:textField class="countable${parent.profile.constraints.currentCity.maxSize} ${hasErrors(bean: parent, field: 'profile.currentCity', 'errors')}" size="30" name="currentCity" value="${fieldValue(bean: parent, field: 'profile.currentCity').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:textField class="countable${parent.profile.constraints.currentStreet.maxSize} ${hasErrors(bean: parent, field: 'profile.currentStreet', 'errors')}" size="30" name="currentStreet" value="${fieldValue(bean: parent, field: 'profile.currentStreet').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.currentZip', 'errors')}" size="10" name="currentZip" value="${fieldValue(bean: parent, field: 'profile.currentZip').decodeHTML()}"/>
            </td>
          </tr>
        </table>

        <table>

          <tr>
            <td valign="top" class="name"><g:if test="${grailsApplication.config.parentProfile.socialSecurityNumber}">Sozialversicherungsnummer</g:if></td>
            <td valign="top" class="name"><g:if test="${grailsApplication.config.parentProfile.phone}">Telefon</g:if></td>
            <td valign="top" class="name"><g:if test="${grailsApplication.config.parentProfile.citizenship}">Staatsbürgerschaft</g:if></td>
          <tr>

          <tr>
            <td width="210" valign="top" class="value">
              <g:if test="${grailsApplication.config.parentProfile.socialSecurityNumber}">
                <g:textField class="${hasErrors(bean: parent, field: 'profile.socialSecurityNumber', 'errors')}" size="10" name="socialSecurityNumber" value="${fieldValue(bean: parent, field: 'profile.socialSecurityNumber')}"/>
              </g:if>
            </td>
            <td valign="top" class="value">
              <g:if test="${grailsApplication.config.parentProfile.phone}">
                <g:textField class="${hasErrors(bean: parent, field: 'profile.phone', 'errors')}" size="30" name="phone" value="${fieldValue(bean: parent, field: 'profile.phone')}"/>
              </g:if>
            </td>
            <td valign="top" class="value">
              <g:if test="${grailsApplication.config.parentProfile.citizenship}">
                <g:textField class="${hasErrors(bean: parent, field: 'profile.citizenship', 'errors')}" size="30" name="citizenship" value="${fieldValue(bean: parent, field: 'profile.citizenship')}"/>
              </g:if>
            </td>
          </tr>
          
        </table>

        <div class="email">
          <table>
            <tr>
              <erp:isOperator entity="${currentEntity}">
                <td width="80" valign="middle">
                  <g:message code="active"/>
                  <g:checkBox name="enabled" value="${parent?.user?.enabled}"/>
                </td>
              </erp:isOperator>
              <td width="150" valign="middle">
                <g:message code="password"/>:
                <g:link controller="profile" action="changePassword" id="${parent.id}"><g:message code="change"/></g:link>
              </td>
              <td width="280" valign="middle">
                <g:message code="parent.profile.email"/>
                <g:textField class="${hasErrors(bean: parent, field: 'user.email', 'errors')}" size="30" maxlength="80" name="email" value="${fieldValue(bean: parent, field: 'user.email')}"/>
              </td>
              <td valign="middle">
                <g:message code="languageSelection"/>
                <erp:localeSelect class="drop-down-150" name="locale" value="${parent?.user?.locale}"/>
              </td>
            </tr>
          </table>
        </div>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <erp:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${parent.id}" onclick="${erp.getLinks(id: parent.id)}"><g:message code="delete"/></g:link>
        </erp:isOperator>
        <g:link class="buttonGray" action="show" id="${parent.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>

  </div>
</div>
</body>