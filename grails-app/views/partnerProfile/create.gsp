<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Partner anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Partner anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${partner}">
      <div class="errors">
        <g:renderErrors bean="${partner}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="partner.profile.name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.fullName', 'errors')}" size="30" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: partner, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="partner.profile.description"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: partner, field: 'profile.description', 'errors')}" rows="6" cols="50" id="description" name="description" value="${fieldValue(bean: partner, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>
          
          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="partner.profile.email"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: partner, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="website" class="name">
              <label for="email">
                <g:message code="partner.profile.website"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.website', 'errors')}" size="30" maxlength="80" id="website" name="website" value="${fieldValue(bean: partner, field: 'profile.website')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country">
                <g:message code="partner.profile.country"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.country', 'errors')}" size="30" id="country" name="country" value="${fieldValue(bean: partner, field: 'profile.country').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="zip">
                <g:message code="partner.profile.zip"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.zip', 'errors')}" size="30" id="zip" name="zip" value="${fieldValue(bean: partner, field: 'profile.zip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="city">
                <g:message code="partner.profile.city"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: partner, field: 'profile.city').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="street">
                <g:message code="partner.profile.street"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.street', 'errors')}" size="30" id="street" name="street" value="${fieldValue(bean: partner, field: 'profile.street').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="phone">
                <g:message code="partner.profile.phone"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.phone', 'errors')}" size="30" id="phone" name="phone" value="${fieldValue(bean: partner, field: 'profile.phone').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="phone">
                <g:message code="partner.profile.services"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es'}">
                <g:select name="services" id="services" multiple="true" from="${grailsApplication.config.partner_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de'}">
                <g:select name="services" id="services" multiple="true" from="${grailsApplication.config.partner_de}" optionKey="key" optionValue="value"/>
              </g:if>
              %{--<g:textField class="${hasErrors(bean: partner, field: 'profile.phone', 'errors')}" size="30" id="phone" name="phone" value="${fieldValue(bean: partner, field: 'profile.phone').decodeHTML()}"/>--}%
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="locale">
                <g:message code="languageSelection"/>
              </label>
            </td>
            <td valign="top" class="value">
              <app:localeSelect name="locale" value="${partner?.user?.locale}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="enabled">
                <g:message code="active"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="enabled" value="${partner?.user?.enabled}"/>
            </td>
          </tr>

          </tbody>
        </table>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
