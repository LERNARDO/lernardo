<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Pädagoge anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Pädagoge anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${educator}">
      <div class="errors">
        <g:renderErrors bean="${educator}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
 		<table>
 		  <tr class="prop">
			<td valign="top" class="name">
				  <label for="gender">
					<g:message code="educator.profile.gender"/>
				  </label>
			</td>  
			<td valign="top" class="name">
				  <label for="title">
					<g:message code="educator.profile.title"/>
				  </label>
			</td> 
			
			<td valign="top" class="name">
				  <label for="firstName">
					<g:message code="educator.profile.firstName"/>
				  </label>
			</td>  
			<td valign="top" class="name">
              <label for="lastName">
                <g:message code="educator.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="birthDate">
                <g:message code="educator.profile.birthDate"/>
              </label>
            </td>
		  </tr>
		  <tr>
			<td width="90" height="35" valign="middle"  class="value">
              <g:select name="gender" from="${['1':message(code:'male'),'2':message(code:'female')]}" value="${fieldValue(bean:educator,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
			<td width="120"  valign="middle"  class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.title', 'errors')}" size="15"  id="title" name="title" value="${fieldValue(bean: educator, field: 'profile.title').decodeHTML()}"/>
            </td>
			<td width="180"  valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.firstName', 'errors')}" size="25"  id="firstName" name="firstName" value="${fieldValue(bean: educator, field: 'profile.firstName').decodeHTML()}"/>
            </td>
			<td   width="210"  valign="middle"  class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.lastName', 'errors')}" size="30" maxlength="30" id="lastName" name="lastName" value="${fieldValue(bean: educator, field: 'profile.lastName').decodeHTML()}"/>
            </td>
			<td valign="middle" class="value">
              <g:datePicker name="birthDate" value="${educator?.profile?.birthDate}" precision="day" years="${new Date().getYear()+1800..new Date().getYear()+1900}"/>
            </td>
		  </tr>	
		</table>
		
		<table>
		<tr>

            <td class="name">

              <label for="education">
                <g:message code="educator.profile.education"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label>
                <g:message code="educator.profile.employment"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label>
                <g:message code="educator.profile.enlisted"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="290" height="35" valign="middle" class="value">
              <g:select class="drop-down-280" name="education" from="${['Pädagoge','Psychologe','Soziologe','Lehrer (staatl. Ausbildung)','Erzieher','Psychopädagoge','Bildender Künstler','Arzt','Krankenschwester','Wirtschafter','Buchhalter/Steuerberater']}" value="${fieldValue(bean:educator,field:'profile.education')}"/>
            </td>
			<td width="290" valign="middle" class="value">
              <g:select class="drop-down-280" name="employment" from="${['Angestellt','Freier Mitarbeiter','Freiwilliger']}" value="${fieldValue(bean:educator,field:'profile.employment')}"/>
            </td>
			<td valign="middle" class="value">
              <g:select class="drop-down-240" name="enlisted" from="${partner}" value="" noSelection="['':'kein']" optionKey="id" optionValue="profile"/>
            </td>
		</tr>
		
		<tr>
            <td valign="top" class="name">
              <label for="interests">
                <g:message code="educator.profile.interests"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label for="inChargeOf">
                <g:message code="educator.profile.inChargeOf"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label for="languages">
                <g:message code="educator.profile.languages"/>
              </label>
            </td>
		</tr>
		<tr>
			<td valign="top" class="value">
              <g:textArea rows="3" cols="39" class="${hasErrors(bean: educator, field: 'profile.interests', 'errors')}" id="interests" size="42" name="interests" value="${fieldValue(bean: educator, field: 'profile.interests').decodeHTML()}"/>
            </td>
			<td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select class="liste-280" name="inChargeOf" multiple="true" from="${grailsApplication.config.inchargeof_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select class="liste-280" name="inChargeOf" multiple="true" from="${grailsApplication.config.inchargeof_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
			<td valign="top" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select id="liste-240" name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select id="liste-240" name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value"/>
              </g:if>
            </td>
		</tr>
		</table>
				
		<h4>Derzeitige Adresse</h4>
		<div class="contact">
		<table>
		<tr>
			<td valign="top" class="name">
              <label for="currentStreet">
                <g:message code="educator.profile.currentStreet"/>
              </label>
            </td>
						<td valign="top" class="name">
              <label for="currentZip">
                <g:message code="educator.profile.currentZip"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label for="currentCity">
                <g:message code="educator.profile.currentCity"/>
              </label>
            </td>

			<td valign="top" class="name">
              <label for="currentCountry">
                <g:message code="educator.profile.currentCountry"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="280" height="35" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.currentStreet', 'errors')}" size="41" id="currentStreet" name="currentStreet" value="${fieldValue(bean: educator, field: 'profile.currentStreet').decodeHTML()}"/>
            </td>
			<td width="105" valign="middle"  class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.currentZip', 'errors')}" size="12" id="currentZip" name="currentZip" value="${fieldValue(bean: educator, field: 'profile.currentZip').decodeHTML()}"/>
            </td>		
			<td width="210" valign="middle"  class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.currentCity', 'errors')}" size="30" id="currentCity" name="currentCity" value="${fieldValue(bean: educator, field: 'profile.currentCity').decodeHTML()}"/>
            </td>
			<td  valign="middle"  class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.currentCountry', 'errors')}" size="30" id="currentCountry" name="currentCountry" value="${fieldValue(bean: educator, field: 'profile.currentCountry').decodeHTML()}"/>
            </td>
		
		</tr>
		</table>
		</div>
		
		<h4>Herkunft</h4>
		<div class="contact">
		<table>
		<tr>
            <td valign="top" class="name">
              <label for="originStreet">
                <g:message code="educator.profile.originStreet"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label for="originZip">
                <g:message code="educator.profile.originZip"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label for="originCity">
                <g:message code="educator.profile.originCity"/>
              </label>
            </td>
			 <td valign="top" class="name">
              <label for="originCountry">
                <g:message code="educator.profile.originCountry"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="280" height="35" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.originStreet', 'errors')}" size="41" id="originStreet" name="originStreet" value="${fieldValue(bean: educator, field: 'profile.originStreet').decodeHTML()}"/>
            </td>
			<td width="105"  valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.originZip', 'errors')}" size="12" id="originZip" name="originZip" value="${fieldValue(bean: educator, field: 'profile.originZip').decodeHTML()}"/>
            </td>
			<td width=",210"  valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.originCity', 'errors')}" size="30" id="originCity" name="originCity" value="${fieldValue(bean: educator, field: 'profile.originCity').decodeHTML()}"/>
            </td>
			<td valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.originCountry', 'errors')}" size="30" id="originCountry" name="originCountry" value="${fieldValue(bean: educator, field: 'profile.originCountry').decodeHTML()}"/>
            </td>
		
		 </tr>
		
		</table>
		</div>		
		
		<h4>Kontakt im Notfall</h4>
		<div class="contact">
		<table>
		<tr>
            <td valign="top" class="name">
              <label for="contactStreet">
                <g:message code="educator.profile.contactStreet"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label for="contactZip">
                <g:message code="educator.profile.contactZip"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label for="contactCity">
                <g:message code="educator.profile.contactCity"/>
              </label>
            </td>
			 <td valign="top" class="name">
              <label for="contactCountry">
                <g:message code="educator.profile.contactCountry"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="280" height="35" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactStreet', 'errors')}" size="41" id="contactStreet" name="contactStreet" value="${fieldValue(bean: educator, field: 'profile.contactStreet').decodeHTML()}"/>
            </td>
			<td width="105"  valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactZip', 'errors')}" size="12" id="contactZip" name="contactZip" value="${fieldValue(bean: educator, field: 'profile.contactZip').decodeHTML()}"/>
            </td>
			<td width="210"  valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactCity', 'errors')}" size="30" id="contactCity" name="contactCity" value="${fieldValue(bean: educator, field: 'profile.contactCity').decodeHTML()}"/>
            </td>
			<td valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactCountry', 'errors')}" size="30" id="contactCountry" name="contactCountry" value="${fieldValue(bean: educator, field: 'profile.contactCountry').decodeHTML()}"/>
            </td>
		 </tr>		
		</table>	
		
		<table>		
		<tr>
			<td valign="top" class="name">
              <label for="contactPhone">
                <g:message code="educator.profile.contactPhone"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label for="contactMail">
                <g:message code="educator.profile.contactMail"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="280" height="35" valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactPhone', 'errors')}" size="41" id="contactPhone" name="contactPhone" value="${fieldValue(bean: educator, field: 'profile.contactPhone').decodeHTML()}"/>
            </td>	
			<td valign="middle" class="value">
              <g:textField class="${hasErrors(bean: educator, field: 'profile.contactMail', 'errors')}" size="47" id="contactMail" name="contactMail" value="${fieldValue(bean: educator, field: 'profile.contactMail').decodeHTML()}"/>
            </td>	
		</tr>
		</table>
		</div>
		
		<div class="email">
		<table>
		<tr>
			<td width="90"  valign="middle">
			<label for="enabled">
                <g:message code="active"/>
             </label>
			 <g:checkBox name="enabled" value="${educator?.user?.enabled}"/>
			</td>
			<td width="350"  valign="middle">
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
