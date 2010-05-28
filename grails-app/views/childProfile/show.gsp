<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${child.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Kind - ${child.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
	
		<table  width="100%" bgcolor="#dfdfdf"  border="0" cellspacing="10">
		<tbody>
		  <tr>
			<td  width="120"  valign="middle" class="name-show">
            <g:message code="child.profile.gender"/>:
			</td>
			<td  width="200"  valign="middle" class="name-show">
            <g:message code="child.profile.firstName"/>:
			</td>
			 <td width="280"  valign="middle"class="name-show">
            <g:message code="child.profile.lastName"/>:
			</td>
			<td valign="middle" class="name-show">
            <g:message code="child.profile.birthDate"/>:
          </td>
		  </tr>
		  <tr>
			<td valign="top" class="value-show"><app:showGender gender="${child.profile.gender}"/>
			</td>
			<td valign="top" class="value-show">${fieldValue(bean: child, field: 'profile.firstName')}
			</td>
			<td valign="top" class="value-show">${fieldValue(bean: child, field: 'profile.lastName')}
			</td>
			<td valign="top" class="value-show"><g:formatDate date="${child.profile.birthDate}" format="dd. MM. yyyy"/>
			</td>
		  </tr>
		  
		 <g:if test="${child.profile.job}">
		    <tr>
			<td  width="120"  valign="middle" class="name-show">
            &nbsp;
			</td>
			<td  width="200"  valign="middle" class="name-show">
            <g:message code="child.profile.jobType"/>:
			</td>
			 <td width="280"  valign="middle"class="name-show">
            <g:message code="child.profile.jobIncome"/>:
			</td>
			<td valign="middle" class="name-show">
             <g:message code="child.profile.jobFrequency"/>:
          </td>
		  <tr>
			<td valign="top" class="value-show-comb"> <g:message code="child.profile.job"/>: <g:formatBoolean boolean="${child.profile.job}" true="${message(code:'yes')}" false="${message(code:'no')}"/></td>
			<td valign="top" class="value-show"><app:getJobType job="${child.profile.jobType}"/></td>
			<td valign="top" class="value-show">${fieldValue(bean: child, field: 'profile.jobIncome')}</td>
			<td valign="top" class="value-show">${fieldValue(bean: child, field: 'profile.jobFrequency')}</td>
		  </tr>    
		 </g:if>    
		 </tbody>
		</table>

		<div class="email">
		 <app:isAdmin>
              <g:message code="active"/>: 
              <g:formatBoolean boolean="${child.user.enabled}" true="${message(code:'yes')}" false="${message(code:'no')}"/> 
		   </app:isAdmin>
          
		</div>
	

    </div>

    <app:isMeOrAdmin entity="${child}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${child?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
