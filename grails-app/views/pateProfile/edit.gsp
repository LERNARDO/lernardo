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

    <g:hasErrors bean="${pate}">
      <div class="errors">
        <g:renderErrors bean="${pate}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${pate.id}">
      <div class="dialog">
              <table>
          <tr class="prop">
            <td valign="top" class="name">
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
              <g:textField class="countable${pate.profile.constraints.firstName.maxSize} ${hasErrors(bean: pate, field: 'profile.firstName', 'errors')}" size="25" id="firstName" name="firstName" value="${fieldValue(bean: pate, field: 'profile.firstName').decodeHTML()}"/>
            </td>
            <td width="210" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.lastName.maxSize} ${hasErrors(bean: pate, field: 'profile.lastName', 'errors')}" size="30" maxlength="30" id="lastName" name="lastName" value="${fieldValue(bean: pate, field: 'profile.lastName').decodeHTML()}"/>
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
            <td width="90" valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.zip', 'errors')}" size="10" id="zip" name="zip" value="${fieldValue(bean: pate, field: 'profile.zip').decodeHTML()}"/>
            </td>
            <td width="215" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.city.maxSize} ${hasErrors(bean: pate, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: pate, field: 'profile.city').decodeHTML()}"/>
            </td>
            <td width="295" valign="top" class="value">
              <g:textField class="countable${pate.profile.constraints.street.maxSize} ${hasErrors(bean: pate, field: 'profile.street', 'errors')}" size="44" id="street" name="street" value="${fieldValue(bean: pate, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td width="210" height="35" valign="top" class="value">
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

        <!--
                <table>
        <tbody>
		<tr class="prop">
			<td valign="top" class="name">
				  <label for="gender">
					*Geschlecht*
				  </label>
			</td>
			<td valign="top" class="name">
				  <label for="title">
					*Titel*
				  </label>
			</td>

			<td valign="top" class="name">
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
              <label for="birthDate">
               *Geburtsdatum*
              </label>
            </td>
		</tr>
		<tr>
			<td width="90" height="35" valign="middle"  class="value">

            </td>
			<td width="120"  valign="middle"  class="value">

             </td>
			<td width="180"  valign="middle" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.firstName', 'errors')}" size="25"  id="firstName" name="firstName" value="${fieldValue(bean: pate, field: 'profile.firstName').decodeHTML()}"/>
            </td>
			<td   width="210"  valign="middle"  class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.lastName', 'errors')}" size="30" maxlength="30" id="lastName" name="lastName" value="${fieldValue(bean: pate, field: 'profile.lastName').decodeHTML()}"/>
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
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="motherTongue" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="motherTongue" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
          </tr>

          <tr>
           <td width="90" valign="middle" class="value">
                <g:textField class="${hasErrors(bean: pate, field: 'profile.zip', 'errors')}" size="10" id="zip" name="zip" value="${fieldValue(bean: pate, field: 'profile.zip').decodeHTML()}"/>
            </td>
<<<<<<< HEAD
            <td  width="215" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: pate, field: 'profile.city').decodeHTML()}"/>
=======
            <td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value"/>
              </g:if>
>>>>>>> 034191bbb07ddb345330df259e8460a52677e5b1
            </td>
            <td width="280" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.street', 'errors')}" size="40" id="street" name="street" value="${fieldValue(bean: pate, field: 'profile.street').decodeHTML()}"/>
            </td>
            <td  height="35" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.country', 'errors')}" size="30" id="country" name="country" value="${fieldValue(bean: pate, field: 'profile.country').decodeHTML()}"/>
            </td>
        </tr>

        <tr class="prop">
            <td colspan=2 valign="top" class="name">
              <label for="motherTongue">
                <g:message code="pate.profile.motherTongue"/>
              </label>
            </td>
          <td colspan=2 valign="top" class="name">
              <label for="languages">
                <g:message code="pate.profile.languages"/>
              </label>
            </td>

          </tr>

          <tr  class="prop">
            <td colspan=2 valign="top" class="value">
              <g:select class="${hasErrors(bean: pate, field: 'profile.motherTongue', 'errors')}" name="motherTongue" from="${grailsApplication.config.languages}" value="${pate?.profile?.motherTongue}"/>
            </td>
            <td colspan=2 valign="top" class="value">
              <g:select id="liste-240" class="${hasErrors(bean: pate, field: 'profile.languages', 'errors')}" multiple="true" name="languages" from="${grailsApplication.config.languages}" value="${pate?.profile?.languages}"/>
            </td>
          </tr>

		</table>
       -->

        <div class="email">
		<table>
		<tr>
			<app:isAdmin>
			<td width="80"  valign="middle">
                <label for="enabled">
                  <g:message code="active"/>
                </label>
                <app:isAdmin>
                  <g:checkBox name="enabled" value="${pate?.user?.enabled}"/>
                </app:isAdmin>
                <app:notAdmin>
                  <g:checkBox name="enabled" value="${pate?.user?.enabled}" disabled="true"/>
                </app:notAdmin>
              </td>
          </app:isAdmin>
            <td width="150" valign="middle">
              <label>
                <g:message code="password"/>:
              </label>
              <g:link controller="profile" action="changePassword" id="${pate.id}">Ändern</g:link>
            </td>

			<td width="280"  valign="middle">
			<label for="email">
				<g:message code="pate.profile.email"/>
            </label>:
            <g:textField class="${hasErrors(bean: pate, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: pate, field: 'user.email')}"/>
            </td>
			<td valign="middle">
			    <label for="locale">
                <g:message code="languageSelection"/>
				</label>:
				<app:localeSelect class="drop-down-150" name="locale" value="${pate?.user?.locale}"/>
				</td>
		</tr>
		 </table>
		</div>

          
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonRed" action="del" id="${pate.id}" onclick="${app.getLinks(id: pate.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${pate.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
