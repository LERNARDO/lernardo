<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${educator.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${educator.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      
	  	<table>

        <tbody>
		<tr class="prop">
			<td valign="top" class="name-show">
				  <label for="gender">
					<g:message code="educator.profile.gender"/>
				  </label>
			</td>  
			<td valign="top" class="name-show">
				  <label for="title">
					<g:message code="educator.profile.title"/>
				  </label>
			</td> 
			
			<td valign="top" class="name-show">
				  <label for="firstName">
					<g:message code="educator.profile.firstName"/>
				  </label>
			</td>  
			<td valign="top" class="name-show">
              <label for="lastName">
                <g:message code="educator.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="name-show">
              <label for="birthDate">
                <g:message code="educator.profile.birthDate"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="90" height="25" valign="middle"  class="value-show">
			<app:showGender gender="${educator.profile.gender}"/>
            </td>
			<td width="120"  valign="middle"  class="value-show">
		    ${fieldValue(bean: educator, field: 'profile.title') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="180"  valign="middle" class="value-show">
            ${fieldValue(bean: educator, field: 'profile.firstName') ?: '<div class="italic">Leer</div>'}
            </td>
			<td   width="210"  valign="middle"  class="value-show">
            ${fieldValue(bean: educator, field: 'profile.lastName') ?: '<div class="italic">Leer</div>'}
			
			</td>
			<td valign="middle" class="value-show">
			<g:formatDate date="${educator.profile.birthDate}" format="dd. MM. yyyy"/>
            </td>
		</tr>	
		</table>


		<table>
		<tr>
            <td class="name-show">
              <label for="education">
                <g:message code="educator.profile.education"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label>
                <g:message code="educator.profile.employment"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label>
                <g:message code="educator.profile.enlisted"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="280" height="25" valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.education') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="280" valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.employment') ?: '<div class="italic">Leer</div>'}
            </td>
			<td valign="middle" class="value-show">
			${fieldValue(bean: enlistedBy, field: 'profile.fullName') ?: '<div class="italic">Leer</div>'}
            </td>
		</tr>

		<tr>
            <td valign="top" class="name-show">
              <label for="interests">
                <g:message code="educator.profile.interests"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label for="inChargeOf">
                <g:message code="educator.profile.inChargeOf"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label for="languages">
                <g:message code="educator.profile.languages"/>
              </label>
            </td>
		</tr>
		<tr>
			<td height="60" valign="top" class="value-show">
	            ${fieldValue(bean: educator, field: 'profile.interests') ?: '<div class="italic">Leer</div>'}
            </td>
			<td valign="top" class="value-show">
			  ${educator.profile.inChargeOf ? g.join(in:educator.profile.inChargeOf) : '<div class="italic">Leer</div>'}
            </td>
			<td valign="top" class="value-show">
			  <ul>
                <g:each in="${educator.profile.languages}" var="language">
                  <li><app:getLanguages language="${language}"/></li>
                </g:each>
              </ul>
            </td>
		</tr>

        </table>

		<h4>Derzeitige Adresse</h4>
		<div class="contact">
		<table>
		<tr>
			<td valign="top" class="name-show">
              <label for="currentStreet">
                <g:message code="educator.profile.currentStreet"/>
              </label>
            </td>
						<td valign="top" class="name-show">
              <label for="currentZip">
                <g:message code="educator.profile.currentZip"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label for="currentCity">
                <g:message code="educator.profile.currentCity"/>
              </label>
            </td>

			<td valign="top" class="name-show">
              <label for="currentCountry">
                <g:message code="educator.profile.currentCountry"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="280" height="25" valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.currentStreet') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="105" valign="middle"  class="value-show">
			${fieldValue(bean: educator, field: 'profile.currentZip') ?: '<div class="italic">Leer</div>'}
            </td>		
			<td width="210" valign="middle"  class="value-show">
			${fieldValue(bean: educator, field: 'profile.currentCity') ?: '<div class="italic">Leer</div>'}
            </td>
			<td  width="110" valign="middle"  class="value-show">
			${fieldValue(bean: educator, field: 'profile.currentCountry') ?: '<div class="italic">Leer</div>'}
            </td>
		
		</tr>
		</table>
		</div>

		<h4>Herkunft</h4>
		<div class="contact">
		<table>
		<tr>
            <td valign="top" class="name-show">
              <label for="originStreet">
                <g:message code="educator.profile.originStreet"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label for="originZip">
                <g:message code="educator.profile.originZip"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label for="originCity">
                <g:message code="educator.profile.originCity"/>
              </label>
            </td>
			 <td valign="top" class="name-show">
              <label for="originCountry">
                <g:message code="educator.profile.originCountry"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="280" height="25" valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.originStreet') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="105"  valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.originZip') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="210"  valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.originCity') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="110" valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.originCountry') ?: '<div class="italic">Leer</div>'}
            </td>
		
		 </tr>
		
		</table>
		</div>		

		<h4>Kontakt im Notfall</h4>
		<div class="contact">
		<table>
		<tr>
            <td valign="top" class="name-show">
              <label for="contactStreet">
                <g:message code="educator.profile.contactStreet"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label for="contactZip">
                <g:message code="educator.profile.contactZip"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label for="contactCity">
                <g:message code="educator.profile.contactCity"/>
              </label>
            </td>
			 <td valign="top" class="name-show">
              <label for="contactCountry">
                <g:message code="educator.profile.contactCountry"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="280" height="25" valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.contactStreet') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="105"  valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.contactZip') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="210"  valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.contactCity') ?: '<div class="italic">Leer</div>'}
            </td>
			<td width="110" valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.contactPhone') ?: '<div class="italic">Leer</div>'}
            </td>
		 </tr>		
		</table>	

		<table>		
		<tr>
			<td valign="top" class="name-show">
              <label for="contactPhone">
                <g:message code="educator.profile.contactPhone"/>
              </label>
            </td>
			<td valign="top" class="name-show">
              <label for="contactMail">
                <g:message code="educator.profile.contactMail"/>
              </label>
            </td>
		</tr>
		<tr>
			<td width="280" height="25" valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.contactPhone') ?: '<div class="italic">Leere</div>'}
            </td>	
			<td width="340" valign="middle" class="value-show">
			${fieldValue(bean: educator, field: 'profile.contactMail') ?: '<div class="italic">keine Daten eingetragen</div>'}
            </td>	
		</tr>
		</table>
		</div>

	<div class="email">
		<table>
		<tr>
			<app:isAdmin>
			<td width="100"  valign="middle">
                <g:message code="active"/>: 
				<g:formatBoolean boolean="${educator.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/>
              </td>
          </app:isAdmin>
          
			<td width="280"  valign="middle">
			<g:message code="educator.profile.email"/>:
			${fieldValue(bean: educator, field: 'user.email') ?: '<div class="italic">Leer</div>'}
			</td>
			<td valign="middle">
                <g:message code="languageSelection"/>:
				%{--<app:localeSelect class="drop-down-150" name="locale" value="${educator?.user?.locale}"/>--}%
                <app:showLocale locale="${parent?.user?.locale}"/>
				</td>
		</tr>
		 </table>
		</div>

    </div>

    <app:isMeOrAdmin entity="${educator}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${educator?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h5>Eintrittsdaten / Austrittsdaten <app:isMeOrAdmin entity="${educator}"><a href="#" id="show-dates"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Datum hinzufügen" /></a></app:isMeOrAdmin></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-dates" targetId="dates"/>
      </jq:jquery>
      <div id="dates" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'educatorProfile', action:'addDate', id:educator.id]" update="dates2" before="hideform('#dates')">
          <g:datePicker name="date" value="" precision="day"/>
          <g:hiddenField name="type" value="${educator.profile.dates.size() % 2 == 0 ? 'join' : 'end'}" />
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="dates2">
        <g:render template="dates" model="${educator}"/>
      </div>
    </div>

  </div>
</div>
</body>
