<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'groupClient')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'groupClient')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form id="${group.id}">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="40" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <g:textArea class="countable${group.profile.constraints.description.maxSize} ${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="3" cols="50" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="clear"></div>
      </div>

    </g:form>
  </div>
</div>
</body>