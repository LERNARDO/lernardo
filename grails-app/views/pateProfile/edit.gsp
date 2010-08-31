<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="pate.profile.edit"/></title>
</head>

<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="pate.profile.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: pate]"/>

    <g:form action="update" method="post" id="${pate.id}">
      <div class="dialog">
        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="pate.profile.firstName"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.lastName"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.motherTongue"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.languages"/></td>
          </tr>

          <tr>
            <td width="180" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.firstName.maxSize} ${hasErrors(bean: pate, field: 'profile.firstName', 'errors')}" size="25" name="firstName" value="${fieldValue(bean: pate, field: 'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.lastName.maxSize} ${hasErrors(bean: pate, field: 'profile.lastName', 'errors')}" size="30" maxlength="30" name="lastName" value="${fieldValue(bean: pate, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select class="drop-down-205" name="motherTongue" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value" value="${pate.profile.motherTongue}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select class="drop-down-205" name="motherTongue" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value" value="${pate.profile.motherTongue}"/>
              </g:if>
            </td>
            <td width="210" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select class="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value" value="${pate.profile.languages}" noSelection="['': message(code: 'none')]"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select class="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value" value="${pate.profile.languages}" noSelection="['': message(code: 'none')]"/>
              </g:if>
            </td>
          </tr>

        </table>

        <table>
          <tr>
            <td valign="top" class="name"><g:message code="pate.profile.zip"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.city"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.street"/></td>
            <td valign="top" class="name"><g:message code="pate.profile.country"/></td>
          </tr>

          <tr>
            <td width="90" valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.zip', 'errors')}" size="10" name="zip" value="${fieldValue(bean: pate, field: 'profile.zip').decodeHTML()}"/>
            </td>
            <td width="215" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.city.maxSize} ${hasErrors(bean: pate, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: pate, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td width="295" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.street.maxSize} ${hasErrors(bean: pate, field: 'profile.street', 'errors')}" size="44" name="street" value="${fieldValue(bean: pate, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="210" height="35" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="country" from="${grailsApplication.config.nationalities_es}" optionKey="key" optionValue="value" value="${pate.profile.country}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="country" from="${grailsApplication.config.nationalities_de}" optionKey="key" optionValue="value" value="${pate.profile.country}"/>
              </g:if>
            </td>
          </tr>
        </table>

        <div class="email">
          <table>
            <tr>
              <app:isOperator entity="${currentEntity}">
                <td width="80" valign="middle">
                  <g:message code="active"/>
                  <app:isAdmin>
                    <g:checkBox name="enabled" value="${pate?.user?.enabled}"/>
                  </app:isAdmin>
                  <app:notAdmin>
                    <g:checkBox name="enabled" value="${pate?.user?.enabled}" disabled="true"/>
                  </app:notAdmin>
                </td>
              </app:isOperator>
              <td width="150" valign="middle">
                <g:message code="password"/>:
                <g:link controller="profile" action="changePassword" id="${pate.id}"><g:message code="change"/></g:link>
              </td>

              <td width="280" valign="middle">
                <g:message code="pate.profile.email"/>:
                <g:textField class="${hasErrors(bean: pate, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: pate, field: 'user.email')}"/>
              </td>
              <td valign="middle">
                <g:message code="languageSelection"/>:
                <app:localeSelect class="drop-down-150" name="locale" value="${pate?.user?.locale}"/>
              </td>
            </tr>
          </table>
        </div>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${pate.id}" onclick="${app.getLinks(id: pate.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${pate.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
