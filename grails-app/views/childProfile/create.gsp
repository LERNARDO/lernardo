<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Kind anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Kind anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${child}">
      <div class="errors">
        <g:renderErrors bean="${child}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <!-- karin todo begin -->

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="childProfile.firstName.label" default="First Name"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.firstName', 'errors')}">
              <input type="text" maxlength="50" id="firstName" name="firstName" value="${fieldValue(bean: child, field: 'profile.firstName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="childProfile.lastName.label" default="Last Name"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.lastName', 'errors')}">
              <input type="text" maxlength="50" id="lastName" name="lastName" value="${fieldValue(bean: child, field: 'profile.lastName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="childProfile.email.label" default="E-Mail"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: child, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: child, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobType">
                <g:message code="childProfile.jobType.label" default="Job Type"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobType', 'errors')}">
              <g:select name="jobType" from="${['Jobtyp1','Jobtyp2']}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobIncome">
                <g:message code="childProfile.jobIncome.label" default="Job Income"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobIncome', 'errors')}">
              <input type="text" id="jobIncome" name="jobIncome" value="${fieldValue(bean: child, field: 'profile.jobIncome')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="jobFrequency">
                <g:message code="childProfile.jobFrequency.label" default="Job Frequency"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.jobFrequency', 'errors')}">
              <input type="text" maxlength="20" id="jobFrequency" name="jobFrequency" value="${fieldValue(bean: child, field: 'profile.jobFrequency')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="job">
                <g:message code="childProfile.job.label" default="Job"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.job', 'errors')}">
              <g:checkBox name="job" value="${child?.profile?.job}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="gender">
                <g:message code="childProfile.gender.label" default="Gender"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.gender', 'errors')}">
              <g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:child,field:'profile.gender')}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="birthDate">
                <g:message code="childProfile.birthDate.label" default="Birth Date"/>
              </label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: child, field: 'profile.birthDate', 'errors')}">
              <g:datePicker name="birthDate" value="${child?.profile?.birthDate}" precision="minute"/>
            </td>
          </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="showTips">
              <g:message code="childProfile.showTips.label" default="Tipps?"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:checkBox name="showTips" value="${child?.profile?.showTips}"/>
          </td>
        </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="enabled">
                <g:message code="childProfile.enabled.label" default="Aktiv?"/>
              </label>

            </td>
            <td valign="top" class="value">
              <g:checkBox name="enabled" value="${child?.user?.enabled}"/>
            </td>
          </tr>

          <!-- karin todo end -->

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="Speichern"/>
        <g:link class="buttonGray" action="list">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
