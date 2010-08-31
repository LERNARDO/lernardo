<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Erziehungsberechtigten bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Erziehungsberechtigten bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: parent]"/>

    <g:form action="update" method="post" id="${parent.id}">
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
            <td valign="middle" class="name">Kommentar:</td>
            <td valign="middle" class="name"><g:message code="parent.profile.education"/>:</td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select id="drop-down-200" name="maritalStatus" from="${grailsApplication.config.maritalStatus_es}" optionKey="key" optionValue="value" value="${parent.profile.maritalStatus}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select id="drop-down-200" name="maritalStatus" from="${grailsApplication.config.maritalStatus_de}" optionKey="key" optionValue="value" value="${parent.profile.maritalStatus}"/>
              </g:if>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select id="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value" value="${parent.profile.languages}" noSelection="['': message(code: 'none')]"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select id="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value" value="${parent.profile.languages}" noSelection="['': message(code: 'none')]"/>
              </g:if>
            </td>
            <td valign="top" class="value">
              <g:textArea class="countable${parent.profile.constraints.comment.maxSize}" name="comment" rows="3" cols="27" value="${fieldValue(bean: parent, field: 'profile.comment')}"/>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select class="drop-down-205" name="education" id="education" from="${grailsApplication.config.schoolLevels_es}" optionKey="key" optionValue="value" value="${parent.profile.education}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select class="drop-down-205" name="education" id="education" from="${grailsApplication.config.schoolLevels_de}" optionKey="key" optionValue="value" value="${parent.profile.education}"/>
              </g:if>
            </td>
          </tr>

          <tr>
            <td valign="middle" class="name">&nbsp;</td>
            <td valign="middle" class="name"><g:message code="parent.profile.jobType"/>:</td>
            <td valign="middle" class="name"><g:message code="parent.profile.jobIncome"/>:</td>
            <td valign="middle" class="name"><g:message code="parent.profile.jobFrequency"/>:</td>
          </tr>

          <tr>
            <td valign="top" class="value-comb"><g:message code="parent.profile.job"/>:
              <g:checkBox name="job" value="${parent?.profile?.job}"/>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="jobType" id="jobType" from="${grailsApplication.config.jobs_es}" optionKey="key" optionValue="value" value="${parent.profile.jobType}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="jobType" id="jobType" from="${grailsApplication.config.jobs_de}" optionKey="key" optionValue="value" value="${parent.profile.jobType}"/>
              </g:if>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobIncome', 'errors')}" size="30" id="jobIncome" name="jobIncome" value="${parent?.profile?.jobIncome?.toInteger()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.jobFrequency', 'errors')}" size="30" id="jobFrequency" name="jobFrequency" value="${parent?.profile?.jobFrequency}"/>
            </td>
          </tr>

          <tr>
            <td valign="top" class="name"><g:message code="parent.profile.currentCountry"/></td>
            <td valign="top" class="name"><g:message code="parent.profile.currentCity"/></td>
            <td valign="top" class="name"><g:message code="parent.profile.currentStreet"/></td>
            <td valign="top" class="name"><g:message code="parent.profile.currentZip"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="currentCountry" from="${grailsApplication.config.nationalities_es}" optionKey="key" optionValue="value" value="${parent.profile.currentCountry}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="currentCountry" from="${grailsApplication.config.nationalities_de}" optionKey="key" optionValue="value" value="${parent.profile.currentCountry}"/>
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

        <div class="email">
          <table>
            <tr>
              <app:isOperator entity="${currentEntity}">
                <td width="80" valign="middle">
                  <g:message code="active"/>
                  <g:checkBox name="enabled" value="${parent?.user?.enabled}"/>
                </td>
              </app:isOperator>
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
                <app:localeSelect class="drop-down-150" name="locale" value="${parent?.user?.locale}"/>
              </td>
            </tr>
          </table>
        </div>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${parent.id}" onclick="${app.getLinks(id: parent.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${parent.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>

  </div>
</div>
</body>