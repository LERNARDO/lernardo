<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${parent.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${parent.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
    <table  width="100%" bgcolor="#dfdfdf"  border="0" cellspacing="10">
		<tbody>
		  <tr>
			<td  width="120"  valign="middle" class="name-show">
            <g:message code="parent.profile.gender"/>:
			</td>
			<td  width="200"  valign="middle" class="name-show">
            <g:message code="parent.profile.firstName"/>:
			</td>
			 <td width="280"  valign="middle"class="name-show">
            <g:message code="parent.profile.lastName"/>:
			</td>
			<td valign="middle" class="name-show">
            <g:message code="parent.profile.birthDate"/>:
          </td>
		  </tr>
		  <tr>
			<td valign="top" class="value-show">
            <app:showGender gender="${parent.profile.gender}"/>
			</td>
			<td valign="top" class="value-show">
            ${fieldValue(bean: parent, field: 'profile.firstName') ?: '<div class="italic">keine Daten eingetragen</div>'}
			</td>
			<td valign="top" class="value-show">
             <g:link action="show" id="${parent.id}" params="[entity:parent.id]">${parent.profile.lastName}</g:link> <g:if test="${family}">(<g:link controller="groupFamilyProfile" action="show" id="${family.id}">Familie ${family.profile.fullName}</g:link>)</g:if>
			</td>
			<td valign="top" class="value-show">
            <g:formatDate date="${parent.profile.birthDate}" format="dd. MM. yyyy"/>
			</td>
		  </tr>

        <tr>
			<td  width="120"  valign="middle" class="name-show">
            <g:message code="parent.profile.maritalStatus"/>:
			</td>
			<td  width="200"  valign="middle" class="name-show" colspan="2" >
            <g:message code="parent.profile.languages"/>:
			</td>
			 <td width="280"  valign="middle"class="name-show">
            <g:message code="parent.profile.education"/>:
			</td>

		  </tr>
		  <tr>
			<td valign="top" class="value-show">
             ${fieldValue(bean: parent, field: 'profile.maritalStatus') ?: '<div class="italic">leer</div>'}
			</td>
			<td valign="top" class="value-show" colspan="2" >
              <ul>
                <g:each in="${parent.profile.languages}" var="language">
                  <li><app:getLanguages language="${language}"/></li>
                </g:each>
              </ul>
			</td>
			<td valign="top" class="value-show">
            <app:getSchoolLevel level="${parent.profile.education}"/>
             %{--${fieldValue(bean: parent, field: 'profile.education') ?: '<div class="italic">keine Daten eingetragen</div>'}--}%
			</td>

		  </tr>

		 <g:if test="${parent.profile.job}">
		    <tr>
			<td  width="120"  valign="middle" class="name-show">
            &nbsp;
			</td>
			<td  width="200"  valign="middle" class="name-show">
            <g:message code="parent.profile.jobType"/>:
			</td>
			 <td width="280"  valign="middle"class="name-show">
            <g:message code="parent.profile.jobIncome"/>:
			</td>
			<td valign="middle" class="name-show">
             <g:message code="parent.profile.jobFrequency"/>:
          </td>
		  <tr>
			<td valign="top" class="value-show-comb"> <g:message code="parent.profile.job"/>:
              <g:formatBoolean boolean="${parent.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
			<td valign="top" class="value-show">${fieldValue(bean: parent, field: 'profile.jobType')}</td>
			<td valign="top" class="value-show">${fieldValue(bean: parent, field: 'profile.jobIncome')}</td>
			<td valign="top" class="value-show">${fieldValue(bean: parent, field: 'profile.jobFrequency')}</td>
		  </tr>
		 </g:if>
		
		<tr>
			<td valign="top" class="name-show">
                 <g:message code="parent.profile.currentCountry"/>
            </td>
						<td valign="top" class="name-show">
                <g:message code="parent.profile.currentCity"/>
            </td>
			<td valign="top" class="name-show">
                <g:message code="parent.profile.currentStreet"/>
            </td>

			<td valign="top" class="name-show">
              <g:message code="parent.profile.currentZip"/>
            </td>
		</tr>
		<tr>
			<td valign="middle" class="value-show">
			${fieldValue(bean: parent, field: 'profile.currentCountry') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="105" valign="middle"  class="value-show">
			  ${fieldValue(bean: parent, field: 'profile.currentCity') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="210" valign="middle"  class="value-show">
			${fieldValue(bean: parent, field: 'profile.currentStreet') ?: '<div class="italic">Leer</div>'}

            </td>
			<td   valign="middle"  class="value-show">
            ${fieldValue(bean: parent, field: 'profile.currentZip') ?: '<div class="italic">Leer</div>'}


            </td>

		</tr>
		</table>

      <div class="email">
		<table>
		<tr>
			<app:isAdmin>
			<td width="100"  valign="middle">
                <g:message code="active"/>:
				<g:formatBoolean boolean="${parent.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
          </app:isAdmin>

			<td width="280"  valign="middle">
			<g:message code="educator.profile.email"/>:
			${fieldValue(bean: parent, field: 'user.email') ?: '<div class="italic">Leer</div>'}
			</td>
			<td valign="middle">
                <g:message code="languageSelection"/>:
				%{--<app:localeSelect class="drop-down-150" name="locale" value="${parent?.user?.locale}"/>--}%
                %{--${parent?.user?.locale}--}%
                <app:showLocale locale="${parent?.user?.locale}"/>
				</td>
		</tr>
		 </table>
	</div>

      Kommentar: ${fieldValue(bean: parent, field: 'profile.comment')}



    </div>

    <app:isMeOrAdmin entity="${parent}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${parent?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
