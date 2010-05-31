<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Pate anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Pate anlegen</h1>
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
            <td height="22" valign="top" class="name">
              <label for="firstName">
                <g:message code="pate.profile.firstName"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="pate.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="motherTongue">
                <g:message code="pate.profile.motherTongue"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="languages">
                <g:message code="pate.profile.languages"/>
              </label>
            </td>
          </tr>
          <tr>
            <td width="180" valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.firstName', 'errors')}" size="25" id="firstName" name="firstName" value="${fieldValue(bean: educator, field: 'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.lastName', 'errors')}" size="30" maxlength="30" id="lastName" name="lastName" value="${fieldValue(bean: educator, field: 'profile.lastName').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select class="drop-down-205" name="motherTongue" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select class="drop-down-205" name="motherTongue" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
            <td width="210" valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select class="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select class="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
          </tr>
        </table>

        <table>
          <tr>
            <td valign="top" class="name">
              <label for="zip">
                <g:message code="pate.profile.zip"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="city">
                <g:message code="pate.profile.city"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="street">
                <g:message code="pate.profile.street"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="country">
                <g:message code="pate.profile.country"/>
              </label>
            </td>
          </tr>

          <tr>
            <td width="90" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.zip', 'errors')}" size="10" id="zip" name="zip" value="${fieldValue(bean: pate, field: 'profile.zip').decodeHTML()}"/>
            </td>
            <td width="215" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: pate, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td width="295" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.street', 'errors')}" size="44" id="street" name="street" value="${fieldValue(bean: pate, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="210" height="35" valign="middle" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="country" from="${grailsApplication.config.nationalities_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="country" from="${grailsApplication.config.nationalities_de}" optionKey="key" optionValue="value"/>
              </g:if>
              %{--<g:textField class="${hasErrors(bean: pate, field: 'profile.country', 'errors')}" size="29" id="country" name="country" value="${fieldValue(bean: pate, field: 'profile.country').decodeHTML()}"/>--}%
            </td>
          </tr>
        </table>

          <div class="email">
            <table>
              <tr>
                <td width="90" valign="middle">
                  <label for="enabled">
                    <g:message code="active"/>
                  </label>
                  <g:checkBox name="enabled" value="${educator?.user?.enabled}"/>
                </td>
                <td width="350" valign="middle">
                  <label for="email">
                    <g:message code="educator.profile.email"/>
                  </label>:
                <g:textField class="${hasErrors(bean: educator, field: 'user.email', 'errors')}" size="40" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: educator, field: 'user.email')}"/>
                </td>
                <td>
                  <label for="locale">
                    <g:message code="languageSelection"/>
                  </label>:
                <app:localeSelect class="drop-down-200" name="locale" value="${educator?.user?.locale}"/>
                </td>
              </tr>
            </table>
          </div>



        <div class="buttons">
          <g:submitButton name="submitButton" value="${message(code:'save')}"/>
          <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
          <div class="spacer"></div>
        </div>

      </div> <!-- div close dialog -->
    </g:form>
  </div>
</div>
</body>