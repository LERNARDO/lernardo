<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private" />
  <title><g:message code="partner.profile.edit"/></title>
</head>
<body>
  <div class="headerGreen">
    <div class="second">
      <h1><g:message code="partner.profile.edit"/></h1>
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
         <tr class="prop">
            <td class="name">
            <g:message code="partner.profile.name"/>:
            </td>
            <td colspan="2" valign="top" class="name">
             <g:message code="partner.profile.description"/>:
            </td>
            <td valign="top" class="name">
            <g:message code="partner.profile.website"/>:
            </td>
         </tr>
         <tr class="prop">
            <td valign="top"  class="value">
              <g:textField class="countable${partner.profile.constraints.fullName.maxSize} ${hasErrors(bean: partner, field: 'profile.fullName', 'errors')}" size="42" id="fullName" name="fullName" value="${fieldValue(bean: partner, field: 'profile.fullName').decodeHTML()}"/>
             </td>
           <td valign="top" colspan="2" class="value">
             <g:textArea class="countable${partner.profile.constraints.description.maxSize} ${hasErrors(bean: partner, field: 'profile.description', 'errors')}" rows="1" cols="45" id="description" name="description" value="${fieldValue(bean: partner, field: 'profile.description').decodeHTML()}"/>
            </td>
           <td valign="top" class="value">
             <g:textField class="${hasErrors(bean: partner, field: 'profile.website', 'errors')}" size="30" maxlength="80" id="website" name="website" value="${fieldValue(bean: partner, field: 'profile.website')}"/>
            </td>
         </tr>

        <tr class="prop">
            <td valign="top" class="name">
           <g:message code="partner.profile.phone"/>:
            </td>
            <td colspan="3" valign="top" class="name">
             <g:message code="partner.profile.services"/>:
            </td>

         </tr>
         <tr class="prop">
            <td valign="top"width="200" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.phone', 'errors')}" size="42" id="phone" name="phone" value="${fieldValue(bean: partner, field: 'profile.phone').decodeHTML()}"/>
           <td width="421" colspan="3" class="value">
           <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
           <g:select class="liste-300" name="services" id="services" multiple="true" from="${grailsApplication.config.partner_es}" optionKey="key" optionValue="value"/>
            </g:if>
            <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
            <g:select class="liste-300"  name="services" id="services" multiple="true" from="${grailsApplication.config.partner_de}" optionKey="key" optionValue="value"/>
            </g:if>
          %{--<g:textField class="${hasErrors(bean: partner, field: 'profile.phone', 'errors')}" size="30" id="phone" name="phone" value="${fieldValue(bean: partner, field: 'profile.phone').decodeHTML()}"/>--}%

           </td>
         </tr>
        <tr class="prop">
          <td colspan="4" valign="middle" class="name">
          Colonia:
          </td>
          </tr>
          <tr class="prop">
          <td colspan="4" valign="middle" class="value">
          <g:select from="${allColonias}" class="drop-down-240" name="colonia" optionKey="id" optionValue="profile"/>
          </td>
          </tr>
        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="partner.profile.street"/>:
          </td>
          <td valign="top" class="name">
            <g:message code="partner.profile.zip"/>:
          </td>
          <td valign="top" class="name">
            <g:message code="partner.profile.city"/>:
          </td>
          <td valign="top" class="name">
            <g:message code="partner.profile.country"/>:
          </td>
        </tr>
        <tr class="prop">
          <td width="290" valign="top" class="value">
            <g:textField class="countable${partner.profile.constraints.street.maxSize} ${hasErrors(bean: partner, field: 'profile.street', 'errors')}" size="42" id="street" name="street" value="${fieldValue(bean: partner, field: 'profile.street').decodeHTML()}"/>
         </td>
          <td width="101" valign="top" class="value">
            <g:textField class="${hasErrors(bean: partner, field: 'profile.zip', 'errors')}" size="12" id="zip" name="zip" value="${fieldValue(bean: partner, field: 'profile.zip').decodeHTML()}"/>
          </td>
          <td width="220" valign="top" class="value">
            <g:textField class="countable${partner.profile.constraints.city.maxSize} ${hasErrors(bean: partner, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: partner, field: 'profile.city').decodeHTML()}"/>
          </td>
          <td width="210" align="top" class="value">
            <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
              <g:select name="country" from="${grailsApplication.config.nationalities_es}" optionKey="key" optionValue="value"/>
            </g:if>
            <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
              <g:select name="country" from="${grailsApplication.config.nationalities_de}" optionKey="key" optionValue="value"/>
            </g:if>
            %{--<g:textField class="${hasErrors(bean: partner, field: 'profile.country', 'errors')}" size="30" id="country" name="country" value="${fieldValue(bean: partner, field: 'profile.country').decodeHTML()}"/>--}%
         </td>
        </tr>
      </table>  

      <div class="email2">
        <table>
          <tr class="prop">
            <app:isAdmin>
              <td width="90" valign="top" class="name">
                <label for="enabled">
                  <g:message code="active"/>
                </label>
              </td>
              <td width="30" valign="top" class="value">
                <app:isAdmin>
                  <g:checkBox name="enabled" value="${partner?.user?.enabled}"/>
                </app:isAdmin>
                <app:notAdmin>
                  <g:checkBox name="enabled" value="${partner?.user?.enabled}" disabled="true"/>
                </app:notAdmin>
              </td>
            </app:isAdmin>
            <td width="70" valign="top" class="name">
              <label for="email">
                <g:message code="facility.profile.email"/>
              </label>
            </td>
            <td width="320" valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'user.email', 'errors')}" size="47" maxlength="80" id="email" name="email" value="${fieldValue(bean: partner, field: 'user.email')}"/>
            </td>
            <td width="130" valign="top" class="name">
              <label for="locale">
                <g:message code="languageSelection"/>
              </label>
            </td>
            <td valign="top" class="value">
              <app:localeSelect class="drop-down-150" name="locale" value="${partner?.user?.locale}"/>
            </td>
          </tr>
          <tr>
            <td valign="top" class="name">
              <label>
                <g:message code="showTips"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${partner.profile.showTips}"/>
            </td>
            <td valign="top" class="name">
              <label>
                <g:message code="password"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:link controller="profile" action="changePassword" id="${partner.id}"><g:message code="change"/></g:link>
            </td>
          </tr>
        </table>
        </div> <!--div email close -->

        </div>
      <div class="buttons">
          <g:submitButton name="submitButton" value="${message(code:'save')}" />
          <app:isOperator entity="${entity}">
            <g:link class="buttonRed" action="del" id="${partner.id}" onclick="${app.getLinks(id: partner.id)}"><g:message code="delete"/></g:link>
          </app:isOperator>
          <g:link class="buttonGray" action="show" id="${partner.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
    </div>
  </div>
 </body>
