<%@ page import="org.springframework.web.servlet.support.RequestContextUtils" %>
<head>
  <meta name="layout" content="private"/>
  <title>Erziehungsberechtigten anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Erziehungsberechtigten anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${parent}">
      <div class="errors">
        <g:renderErrors bean="${parent}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
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
             <g:textField class="${hasErrors(bean:parent,field:'profile.firstName','errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean:parent,field:'profile.firstName').decodeHTML()}"/>
             </td>
             <td valign="top" class="value">
               <g:textField class="${hasErrors(bean: parent, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: parent, field: 'profile.lastName').decodeHTML()}"/>
            </td>
             <td valign="top" class="value">
               <g:datePicker name="birthDate" value="${parent?.profile?.birthDate}" precision="day"/>
             </td>
           </tr>

         <tr>
             <td   valign="middle" class="name">
             <g:message code="parent.profile.maritalStatus"/>:
             </td>
             <td    valign="middle" class="name" colspan="2" >
             <g:message code="parent.profile.languages"/>:
             </td>

             <td valign="middle" class="name">
             <g:message code="parent.profile.education"/>:
           </td>
           </tr>
           <tr>
             <td valign="top" class="value">
               <g:select name="maritalStatus" from="${['ledig','verheiratet','getrennt lebend','geschieden','verwitwet','verpartnert','unbekannt']}" value="${fieldValue(bean:parent,field:'profile.maritalStatus')}"/>
            </td>
             <td valign="top" class="value" colspan="2" >
               <g:if test="${RequestContextUtils.getLocale(request).toString() == 'es'}">
                 <g:select id="liste-240" name="languages" multiple="true" from="${grailsApplication.config.languages_es}" optionKey="key" optionValue="value"/>
               </g:if>
               <g:if test="${RequestContextUtils.getLocale(request).toString() == 'de'}">
                 <g:select id="liste-240" name="languages" multiple="true" from="${grailsApplication.config.languages_de}" optionKey="key" optionValue="value"/>
               </g:if>
             </td>
             <td valign="top" class="value">
               <g:select id="education" name="education" from="${['1. Primaria', '2. Primaria', '3. Primaria', '4. Primaria', '5. Primaria', '6. Primaria', '1. Secundaria', '2. Secundaria', '3. Secundaria', '1. Präparatoria', '2. Präparatoria', '3. Präparatoria']}" value="${fieldValue(bean: parent, field: 'profile.education')}"/>
            </td>
           </tr>


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
              <g:checkBox name="job" value="${parent?.profile?.job}"/>
             <td valign="top" class="value">
             <g:textField class="${hasErrors(bean: parent, field: 'profile.jobType', 'errors')}" size="30" id="jobType" name="jobType" value="${fieldValue(bean: parent, field: 'profile.jobType').decodeHTML()}"/>

             <td valign="top" class="value">
             <g:textField class="${hasErrors(bean: parent, field: 'profile.jobIncome', 'errors')}" size="30" id="jobIncome" name="jobIncome" value="${parent?.profile?.jobIncome?.toInteger()}"/>

            <td valign="top" class="value">

             <g:textField class="${hasErrors(bean: parent, field: 'profile.jobFrequency', 'errors')}" size="30" id="jobFrequency" name="jobFrequency" value="${parent?.profile?.jobFrequency?.toInteger()}"/>

           </tr>


         <tr>
             <td valign="top" class="name">
               <label for="currentCountry">
                  <g:message code="parent.profile.currentCountry"/>

               </label>
             </td>
                         <td valign="top" class="name">
               <label for="currentCity">
                 <g:message code="parent.profile.currentCity"/>
               </label>
             </td>
             <td valign="top" class="name">
               <label for="currentStreet">
                 <g:message code="parent.profile.currentStreet"/>
               </label>
             </td>

             <td valign="top" class="name">
               <label for="currentZip">
               <g:message code="parent.profile.currentZip"/>
               </label>
             </td>
         </tr>
         <tr>
             <td valign="middle" class="value">
               <g:textField class="${hasErrors(bean: parent, field: 'profile.country', 'errors')}" size="20" id="currentCountry" name="currentCountry" value="${fieldValue(bean: parent, field: 'profile.currentCountry').decodeHTML()}"/>
             </td>
             <td width="105" valign="middle"  class="value">
               <g:textField class="${hasErrors(bean: parent, field: 'profile.currentCity', 'errors')}" size="30" id="currentCity" name="currentCity" value="${fieldValue(bean: parent, field: 'profile.currentCity').decodeHTML()}"/>
            </td>
             <td width="210" valign="middle"  class="value">
               <g:textField class="${hasErrors(bean: parent, field: 'profile.currentStreet', 'errors')}" size="30" id="currentStreet" name="currentStreet" value="${fieldValue(bean: parent, field: 'profile.currentStreet').decodeHTML()}"/>
              </td>
             <td   valign="middle"  class="value">
               <g:textField class="${hasErrors(bean: parent, field: 'profile.currentZip', 'errors')}" size="30" id="currentZip" name="currentZip" value="${fieldValue(bean: parent, field: 'profile.currentZip').decodeHTML()}"/>
            </td>

         </tr>
         </table>

           <div class="email">
		<table>
		<tr>
			<td width="80"  valign="middle">
                <label for="enabled">
                  <g:message code="active"/>
                </label>
                <g:checkBox name="enabled" value="${parent?.user?.enabled}"/>
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
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
