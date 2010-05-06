<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Kind bearbeiten</title>
</head>
<body>
<div class="headerBlue">
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

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="child.profile.firstName"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.firstName', 'errors')}">
              <input type="text" maxlength="50" id="firstName" name="firstName" value="${fieldValue(bean: child, field: 'profile.firstName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="child.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.lastName', 'errors')}">
              <input type="text" maxlength="50" id="lastName" name="lastName" value="${fieldValue(bean: child, field: 'profile.lastName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="child.profile.email"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: child, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: child, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="gender">
                <g:message code="child.profile.gender"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.gender', 'errors')}">
              <g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:child,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="job">
                <g:message code="child.profile.job"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.job', 'errors')}">
              <g:checkBox name="job" value="${child?.profile?.job}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobType">
                <g:message code="child.profile.jobType"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobType', 'errors')}">
              <g:select name="jobType" from="${['Jobtyp1','Jobtyp2']}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobIncome">
                <g:message code="child.profile.jobIncome"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobIncome', 'errors')}">
              <input type="text" id="jobIncome" name="jobIncome" value="${fieldValue(bean: child, field: 'profile.jobIncome')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobFrequency">
                <g:message code="child.profile.jobFrequency"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobFrequency', 'errors')}">
              <input type="text" maxlength="20" id="jobFrequency" name="jobFrequency" value="${fieldValue(bean: child, field: 'profile.jobFrequency')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="birthDate">
                <g:message code="child.profile.birthDate"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.birthDate', 'errors')}">
              <g:datePicker name="birthDate" value="${child?.profile?.birthDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="showTips">
                <g:message code="showTips"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${child?.profile?.showTips}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="enabled">
                <g:message code="active"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="enabled" value="${child?.user?.enabled}"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="show" id="${child.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>