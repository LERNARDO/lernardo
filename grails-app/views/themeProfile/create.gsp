<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.create" args="[message(code: 'theme')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'theme')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: theme]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: theme, field: 'profile.fullName', 'errors')}" required="" size="40" name="fullName" value="${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="begin"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField name="startDate" required="" class="datepicker ${hasErrors(bean: theme, field: 'profile.startDate', 'errors')}" value="${formatDate(date: theme?.profile?.startDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="end"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField name="endDate" required="" class="datepicker ${hasErrors(bean: theme, field: 'profile.endDate', 'errors')}" value="${formatDate(date: theme?.profile?.endDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="themes.superior"/></td>
          <td class="value">
            <g:select from="${allThemes}" name="parenttheme" optionKey="id" optionValue="profile" noSelection="[null: 'Keines']"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="facility"/></td>
          <td class="value">
            <g:select from="${allFacilities}" name="facility" optionKey="id" optionValue="profile" value=""/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <g:textArea data-counter="2000" class="${hasErrors(bean: theme, field: 'profile.description', 'errors')}" rows="4" cols="50" name="description" value="${fieldValue(bean: theme, field: 'profile.description').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>