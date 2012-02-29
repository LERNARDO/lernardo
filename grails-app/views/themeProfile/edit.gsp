<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.edit" args="[message(code: 'theme')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'theme')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: theme]"/>

    <g:form id="${theme.id}">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: theme, field: 'profile.fullName', 'errors')}" size="40" name="fullName" value="${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="begin"/></td>
          <td valign="top" class="value">
            <g:textField name="startDate" class="datepicker ${hasErrors(bean: theme, field: 'profile.startDate', 'errors')}" value="${formatDate(date: theme?.profile?.startDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="end"/></td>
          <td valign="top" class="value">
            <g:textField name="endDate" class="datepicker ${hasErrors(bean: theme, field: 'profile.endDate', 'errors')}" value="${formatDate(date: theme?.profile?.endDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="themes.superior"/></td>
          <td valign="top" class="value">
            <g:select from="${allThemes}" name="parenttheme" optionKey="id" optionValue="profile" noSelection="[null: 'Keines']"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="facility"/></td>
          <td valign="top" class="value">
            <g:select from="${allFacilities}" name="facility" optionKey="id" optionValue="profile" value=""/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <g:textArea class="countable2000 ${hasErrors(bean: theme, field: 'profile.description', 'errors')}" rows="4" cols="50" name="description" value="${fieldValue(bean: theme, field: 'profile.description').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      %{--<div>

        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
            <td valign="top" class="name"><g:message code="begin"/></td>
            <td valign="top" class="name"><g:message code="end"/></td>
          </tr>

          <tr>
            <td width="300" valign="top" class="value">
              <g:textField class="countable${theme.profile.constraints.fullName.maxSize} ${hasErrors(bean: theme, field: 'profile.fullName', 'errors')}" size="42" id="fullName" name="fullName" value="${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="230" valign="top" class="value">
              <g:textField name="startDate" size="30" class="datepicker" value="${formatDate(date: theme?.profile?.startDate, format: 'dd. MM. yyyy')}"/>
            </td>
            <td width="230" valign="top" class="value">
              <g:textField name="endDate" size="30" class="datepicker" value="${formatDate(date: theme?.profile?.endDate, format: 'dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="themes.superior"/></td>
            <td colspan="2" valign="top" class="name"><g:message code="facility"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <g:select from="${allThemes}" name="parenttheme" optionKey="id" optionValue="profile" value="${parenttheme?.id}" noSelection="[null:'Keines']"/>
            </td>
            <td colspan="2" valign="top" class="value">
              <g:select from="${allFacilities}" name="facility" optionKey="id" optionValue="profile" value="${facility.id}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="description"/></td>
          </tr>

          <tr>
            <td colspan="3" valign="top" class="value">
              <g:textArea class="countable${theme.profile.constraints.description.maxSize} ${hasErrors(bean: theme, field: 'profile.description', 'errors')}" rows="3" cols="120" name="description" value="${fieldValue(bean: theme, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          </tbody>
        </table>

      </div>--}%

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="clear"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
