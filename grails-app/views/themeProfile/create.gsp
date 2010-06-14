<head>
  <meta name="layout" content="private"/>
  <title>Thema anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Thema anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <g:hasErrors bean="${theme}">
      <div class="errors">
        <g:renderErrors bean="${theme}" as="list"/>
      </div>
    </g:hasErrors>
    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="theme.profile.name"/>
              </label>
            </td>
             <td valign="top" class="name">
              <label for="startDate">
                <g:message code="theme.profile.startDate"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="endDate">
                <g:message code="theme.profile.endDate"/>
              </label>
            </td>
            </tr>
          <tr>
            <td width="300" valign="top" class="value">
              <g:textField class="${hasErrors(bean: theme, field: 'profile.fullName', 'errors')}" size="42" id="fullName" name="fullName" value="${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}"/>
            </td>
           <td width="230" valign="top" class="value">
              <g:datePicker class="${hasErrors(bean: theme, field: 'profile.startDate', 'errors')}" name="startDate" value="${theme?.profile?.startDate}" precision="day"/>
            </td> 
            <td width="230" valign="top" class="value">
              <g:datePicker class="${hasErrors(bean: theme, field: 'profile.endDate', 'errors')}" name="endDate" value="${theme?.profile?.endDate}" precision="day"/>
            </td>
          </tr>
            <tr class="prop">
            <td valign="top" class="name">
              <label for="type">
                <g:message code="theme.profile.type"/>
              </label>
              </td>
           <td colspan="2" valign="top" class="name">
              <label for="type">
                <g:message code="facility"/>
              </label>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <g:select  class="${hasErrors(bean: theme, field: 'profile.type', 'errors')} drop-down-280" from="${['Übergeordnetes Thema','Subthema']}" id="type" name="type" value="${fieldValue(bean: theme, field: 'profile.type')}"/>
            </td>
            <td colspan="2" valign="top" class="value">
              <g:select from="${allFacilities}" name="facility" optionKey="id" optionValue="profile" value=""/>
            </td>
          </tr>


          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="theme.profile.description"/>
              </label>
            </td>
            </tr>
          <tr>
            <td colspan="3" valign="top" class="value">
              <g:textArea class="${hasErrors(bean: theme, field: 'profile.description', 'errors')}" rows="1" cols="120" name="description" value="${fieldValue(bean: theme, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>





          </tbody>
        </table>
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