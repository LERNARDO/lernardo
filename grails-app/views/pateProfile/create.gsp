<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="pate.profile.create"/></title>
</head>

<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="pate.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${pate}">
      <div class="errors">
        <g:renderErrors bean="${pate}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
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
              <g:textField class="countable50 ${hasErrors(bean: pate, field: 'profile.firstName', 'errors')}" size="25" name="firstName" value="${fieldValue(bean: pate, field: 'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: pate, field: 'profile.lastName', 'errors')}" size="30" name="lastName" value="${fieldValue(bean: pate, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select class="drop-down-205" name="motherTongue" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value" value="${pate?.profile?.motherTongue}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select class="drop-down-205" name="motherTongue" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value" value="${pate?.profile?.motherTongue}"/>
              </g:if>
            </td>
            <td width="210" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select class="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value" value="${pate?.profile?.languages}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select class="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value" value="${pate?.profile?.languages}"/>
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
              <g:textField class="countable50 ${hasErrors(bean: pate, field: 'profile.city', 'errors')}" size="30" name="city" value="${fieldValue(bean: pate, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td width="295" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: pate, field: 'profile.street', 'errors')}" size="44" name="street" value="${fieldValue(bean: pate, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="210" height="35" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="country" from="${grailsApplication.config.nationalities_es}" optionKey="key" optionValue="value" value="${pate?.profile?.country}"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="country" from="${grailsApplication.config.nationalities_de}" optionKey="key" optionValue="value" value="${pate?.profile?.country}"/>
              </g:if>
            </td>
          </tr>

        </table>

        <div class="email">
          <table>

            <tr>
              <td width="90" valign="middle">
                <g:message code="active"/>
                <g:checkBox name="enabled" value="${pate?.user?.enabled}"/>
              </td>
              <td width="350" valign="middle">
                <g:message code="educator.profile.email"/>:
                <g:textField class="${hasErrors(bean: pate, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" name="email" value="${fieldValue(bean: pate, field: 'user.email')}"/>
              </td>
              <td>
                <g:message code="languageSelection"/>:
                <app:localeSelect class="drop-down-200" name="locale" value="${pate?.user?.locale}"/>
              </td>
            </tr>

          </table>
        </div>

        <div class="buttons">
          <g:submitButton name="submitButton" value="${message(code:'save')}"/>
          <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
          <div class="spacer"></div>
        </div>

      </div>
    </g:form>
  </div>
</div>
</body>