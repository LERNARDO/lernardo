<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Kind bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Kind bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${child}">
      <div class="errors">
        <g:renderErrors bean="${child}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${child.id}">
      <div class="dialog">
    
		<table>
          <tbody>
				<tr class="prop"> <!-- Prompt-->  
			<td valign="middle" class="name">
              <label for="gender">
                <g:message code="child.profile.gender"/>
              </label>
            </td>
			<td valign="middle" class="name">
				<label for="firstName">
                <g:message code="child.profile.firstName"/>
				</label></td>
			 
            <td valign="middle" class="name">
              <label for="lastName">
                <g:message code="child.profile.lastName"/>
              </label>
            </td>
            <td  valign="middle" class="value ${hasErrors(bean: child, field: 'profile.birthDate', 'errors')}" >
			<label for="birthDate">
                <g:message code="child.profile.birthDate"/>
              </label>
            </td>
          
		</tr>
		<tr>  <!-- Inhalt-->
			
			<td  width="120" height="35" valign="middle" class="value ${hasErrors(bean: child, field: 'profile.gender', 'errors')}">
              <g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:child,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
			<td  width="200" valign="middle" class="value ${hasErrors(bean: child, field: 'profile.firstName', 'errors')}">
				<input type="text" size="25" maxlength="50" id="firstName" name="firstName" value="${fieldValue(bean: child, field: 'profile.firstName')}"/>
			</td>
		
			<td  width="280" valign="middle" class="value ${hasErrors(bean: child, field: 'profile.lastName', 'errors')}">
              <input type="text" size="40"  maxlength="50" id="lastName" name="lastName" value="${fieldValue(bean: child, field: 'profile.lastName')}"/>
            </td>
			<td  height="35"  valign="middle" class="value ${hasErrors(bean: child, field: 'profile.birthDate', 'errors')}" >
              <g:datePicker name="birthDate" value="${child?.profile?.birthDate}" precision="day"/>
            </td>
		</tr>

	
		<tr class="prop"> <!-- Prompt--> 
			<td> &nbsp; </td>
			<td><label for="jobType">
                <g:message code="child.profile.jobType"/>
              </label></td>
			<td><label for="jobIncome">
                <g:message code="child.profile.jobIncome"/>
              </label></td>
			<td> <label for="jobFrequency">
                <g:message code="child.profile.jobFrequency"/>
              </label></td>
		</tr>
		<tr>  <!-- Inhalt-->
		<td  valign="middle" class="value ${hasErrors(bean: child, field: 'profile.job', 'errors')}">
              <label for="job">
                <g:message code="child.profile.job"/>
              </label>
			  <g:checkBox name="job" value="${child?.profile?.job}"/>
            </td>
			<td  height="35" valign="middle" class="value ${hasErrors(bean: child, field: 'profile.jobType', 'errors')}">
              <g:select name="jobType" id="jobType" from="${['Jobtyp1','Jobtyp2']}" value="${child.profile.jobType}"/>
			</td>
			<td  valign="middle"class="value ${hasErrors(bean: child, field: 'profile.jobIncome', 'errors')}">
              <input type="text" id="jobIncome" size="40" name="jobIncome" value="${fieldValue(bean: child, field: 'profile.jobIncome')}"/>
			</td>
			<td class="value ${hasErrors(bean: child, field: 'profile.jobFrequency', 'errors')}">
              <input type="text" size="32" maxlength="20" id="jobFrequency" name="jobFrequency" value="${fieldValue(bean: child, field: 'profile.jobFrequency')}"/>
			</td>
		</tr>
		
	</table>
	

		<div class="email">
              <label for="enabled">
                <g:message code="active"/>
              </label>
              <g:checkBox name="enabled" value="${child?.user?.enabled}"/>
			  
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label for="email">
                <g:message code="child.profile.email"/>
            </label>
			 : &nbsp;
			<g:textField class="${hasErrors(bean: child, field: 'user.email', 'errors')}" size="80" maxlength="80" id="email" name="email" value="${fieldValue(bean: child, field: 'user.email')}"/>
 		
		</div>
        
          %{--</tbody>
        </table>--}%
		  
	</div>

      <div class="buttons">
	  <table border="0">
		  <tr>
			<td width="650" align="left"><label for="showTips">
                <g:message code="showTips"/>
				<g:checkBox name="showTips" value="${child?.profile?.showTips}"/>
              </label></td>
			<td ><g:submitButton  name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div></td>
		  </tr>
	</table>
        
 
      </div>
    </g:form>
  </div>
</div>
</body>