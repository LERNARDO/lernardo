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

    <g:hasErrors bean="${parent}">
      <div class="errors">
        <g:renderErrors bean="${parent}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${parent.id}">
      <div class="dialog">

          <table  width="100%" bgcolor="#dfdfdf"  border="0" cellspacing="10">
		<tbody>
		  <tr>
			<td  width="90"  valign="middle" class="name">
            <g:message code="parent.profile.gender"/>:
			</td>
			<td  width="120"  valign="middle" class="name">
            <g:message code="parent.profile.firstName"/>:
			</td>
			 <td width="180"  valign="middle"class="name">
            <g:message code="parent.profile.lastName"/>:
			</td>
			<td width="210" valign="middle" class="name">
            <g:message code="parent.profile.birthDate"/>:
          </td>
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
              <g:datePicker name="birthDate" value="${parent?.profile?.birthDate}" precision="day" years="${new Date().getYear()+1800..new Date().getYear()+1900}"/>
			</td>
		  </tr>

        <tr>
			<td   valign="middle" class="name">
            <g:message code="parent.profile.maritalStatus"/>:
			</td>
			<td    valign="middle" class="name">
            <g:message code="parent.profile.languages"/>:
			</td>
            <td    valign="middle" class="name">
             Kommentar:
           </td>
			<td valign="middle" class="name">
            <g:message code="parent.profile.education"/>:
          </td>
		  </tr>
		  <tr>
			<td valign="top" class="value">
              %{-- <g:select name="maritalStatus" from="${['ledig','verheiratet','getrennt lebend','geschieden','verwitwet','verpartnert','unbekannt']}" value="${fieldValue(bean:parent,field:'profile.maritalStatus')}"/> --}%
               <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select id="drop-down-200" name="maritalStatus" from="${grailsApplication.config.maritalStatus_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select id="drop-down-200" name="maritalStatus" from="${grailsApplication.config.maritalStatus_de}" optionKey="key" optionValue="value"/>
              </g:if>
             </td>
			<td valign="top" class="value"  >
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select id="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select id="liste-200" name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value"/>
              </g:if>
			</td>
            <td valign="top" class="value"  >
            <g:textArea class="countable${parent.profile.constraints.comment.maxSize}" name="comment" rows="3" cols="27" value="${fieldValue(bean: parent, field: 'profile.comment')}"/>
            
            </td>
			<td valign="top" class="value">
                 %{--<g:select id="education" name="education" from="${1..12}" value="${fieldValue(bean: parent, field: 'profile.education')}"/>--}%
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select class="drop-down-205" name="schoolLevel" id="schoolLevel" from="${grailsApplication.config.schoolLevels_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select class="drop-down-205" name="schoolLevel" id="schoolLevel" from="${grailsApplication.config.schoolLevels_de}" optionKey="key" optionValue="value"/>
              </g:if>
			</td>
		  </tr>

		 <g:if test="${parent.profile.job}">
		    <tr>
			<td    valign="middle" class="name">
            &nbsp;
			</td>
			<td    valign="middle" class="name">
            <g:message code="parent.profile.jobType"/>:
			</td>
			 <td   valign="middle"class="name">
            <g:message code="parent.profile.jobIncome"/>:
			</td>
			<td valign="middle" class="name">
             <g:message code="parent.profile.jobFrequency"/>:
          </td>
		  <tr>
			<td valign="top" class="value-comb"> <g:message code="parent.profile.job"/>:
           
             <g:formatBoolean boolean="${parent.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
           <td valign="top" class="value">
           <g:textField class="${hasErrors(bean: parent, field: 'profile.jobType', 'errors')}" size="30" id="jobType" name="jobType" value="${fieldValue(bean: parent, field: 'profile.jobType').decodeHTML()}"/> </td>
           <td valign="top" class="value">
           <g:textField class="${hasErrors(bean: parent, field: 'profile.jobIncome', 'errors')}" size="30" id="jobIncome" name="jobIncome" value="${parent?.profile?.jobIncome?.toInteger()}"/> </td>
           <td valign="top" class="value">
           <g:textField class="${hasErrors(bean: parent, field: 'profile.jobFrequency', 'errors')}" size="30" id="jobFrequency" name="jobFrequency" value="${parent?.profile?.jobFrequency?.toInteger()}"/> </td>

		  </tr>
		 </g:if>

		<tr>
			<td valign="top" class="name">
              <label for="currentStreet">
                 <g:message code="parent.profile.currentCountry"/>

              </label>
            </td>
						<td valign="top" class="name">
              <label for="currentZip">
                <g:message code="parent.profile.currentCity"/>
              </label>
            </td>
			<td valign="top" class="name">
              <label for="currentCity">
                <g:message code="parent.profile.currentStreet"/>
              </label>
            </td>

			<td valign="top" class="name">
              <g:message code="parent.profile.currentZip"/>
            </td>
		</tr>
		<tr>
			<td valign="middle" class="value">
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es' || RequestContextUtils.getLocale(request).toString() == 'es_ES'}">
                <g:select name="country" from="${grailsApplication.config.nationalities_es}" optionKey="key" optionValue="value"/>
              </g:if>
              <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de' || RequestContextUtils.getLocale(request).toString() == 'de_DE'}">
                <g:select name="country" from="${grailsApplication.config.nationalities_de}" optionKey="key" optionValue="value"/>
              </g:if>
              %{--<g:textField class="${hasErrors(bean: parent, field: 'profile.currentCountry', 'errors')}" size="20" id="currentCountry" name="currentCountry" value="${fieldValue(bean: parent, field: 'profile.currentCountry').decodeHTML()}"/>--}%
           			
            </td>
			<td width="105" valign="middle"  class="value">
              <g:textField class="countable${parent.profile.constraints.currentCity.maxSize} ${hasErrors(bean: parent, field: 'profile.currentCity', 'errors')}" size="30" id="currentCity" name="currentCity" value="${fieldValue(bean: parent, field: 'profile.currentCity').decodeHTML()}"/>
            			 
            </td>
			<td width="210" valign="middle"  class="value">
              <g:textField class="countable${parent.profile.constraints.currentStreet.maxSize} ${hasErrors(bean: parent, field: 'profile.currentStreet', 'errors')}" size="30" id="currentStreet" name="currentStreet" value="${fieldValue(bean: parent, field: 'profile.currentStreet').decodeHTML()}"/>

            </td>
			<td   valign="middle"  class="value">
              <g:textField class="${hasErrors(bean: parent, field: 'profile.currentZip', 'errors')}" size="10" id="currentZip" name="currentZip" value="${fieldValue(bean: parent, field: 'profile.currentZip').decodeHTML()}"/>



            </td>

		</tr>
		</table>

      
       <div class="email">
		<table>
		<tr>
			<app:isAdmin>
			<td width="80"  valign="middle">
                <label for="enabled">
                  <g:message code="active"/>
                </label>
                <app:isAdmin>
                  <g:checkBox name="enabled" value="${parent?.user?.enabled}"/>
                </app:isAdmin>
                <app:notAdmin>
                  <g:checkBox name="enabled" value="${parent?.user?.enabled}" disabled="true"/>
                </app:notAdmin>
              </td>
          </app:isAdmin>
            <td width="150" valign="middle">
              <label>
                <g:message code="password"/>:
              </label>
              <g:link controller="profile" action="changePassword" id="${parent.id}">Ändern</g:link>
            </td>

			<td width="280"  valign="middle">
			<label for="email">
				<g:message code="parent.profile.email"/>
            </label>:
            <g:textField class="${hasErrors(bean: parent, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: parent, field: 'user.email')}"/>
            </td>
			<td valign="middle">
			    <label for="locale">
                <g:message code="languageSelection"/>
				</label>:
				<app:localeSelect class="drop-down-150" name="locale" value="${parent?.user?.locale}"/>
				</td>
		</tr>
		 </table>
		</div>


      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonGray" action="del" id="${parent.id}" onclick="${app.getLinks(id: parent.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${parent.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>

  </div>
</div>
</body>