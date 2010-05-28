<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private" />
  <title>Partner bearbeiten</title>
</head>
<body>
  <div class="headerBlue">
    <div class="second">
      <h1>Partner bearbeiten</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">

      <g:hasErrors bean="${partner}">
      <div class="errors">
          <g:renderErrors bean="${partner}" as="list" />
      </div>
      </g:hasErrors>

      <g:form action="update" method="post" id="${partner.id}">
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
                      <input class="${hasErrors(bean:partner,field:'profile.fullName','errors')}" type="text" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean:partner,field:'profile.fullName')}"/>
                  </td>
              </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="partner.profile.email"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'user.email', 'errors')}" size="30" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: partner, field: 'user.email')}"/>
            </td>
          </tr>

            <tr class="prop">
                  <td valign="top" class="name">
                    <label for="description">
                      <g:message code="partner.profile.description"/>
                    </label>
                  </td>
                  <td valign="top" class="value">
                      <textarea class="${hasErrors(bean:partner,field:'profile.description','errors')}" rows="5" cols="40" id="description" name="description">${fieldValue(bean:partner, field:'profile.description')}</textarea>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="zip">
                      <g:message code="partner.profile.zip"/>
                    </label>
                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.zip','errors')}" type="text" id="zip" name="zip" value="${fieldValue(bean:partner,field:'profile.zip')}" />
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="city">
                      <g:message code="partner.profile.city" />
                    </label>
                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.city','errors')}" type="text" id="city" name="city" value="${fieldValue(bean:partner,field:'profile.city')}"/>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="street">
                      <g:message code="partner.profile.street" />
                    </label>
                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.street','errors')}" type="text" id="street" name="street" value="${fieldValue(bean:partner,field:'profile.street')}"/>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="phone">
                      <g:message code="partner.profile.phone" />
                    </label>
                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.phone','errors')}" type="text" id="phone" name="phone" value="${fieldValue(bean:partner,field:'profile.phone')}"/>
                  </td>
              </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="phone">
                <g:message code="partner.profile.services"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="services" id="services" multiple="true" from="${grailsApplication.config.partner_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
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

              <app:isAdmin>
                <tr class="prop">
                    <td valign="top" class="name">
                      <label for="enabled">
                        <g:message code="active" />
                      </label>
                    </td>
                    <td valign="top" class="value">
                        <g:checkBox name="enabled" value="${fieldValue(bean:partner,field:'user.enabled')}" />
                    </td>
                </tr>
              </app:isAdmin>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="password"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:link controller="profile" action="changePassword" id="${partner.id}">Passwort ändern</g:link>
            </td>
          </tr>

            </tbody>
          </table>
        </div>
      <div class="buttons">
          <g:submitButton name="submitButton" value="${message(code:'save')}" />
           <g:link class="buttonGray" action="show" id="${partner.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
    </div>
  </div>
 </body>
