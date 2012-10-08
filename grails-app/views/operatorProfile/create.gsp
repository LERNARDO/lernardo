<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'operator')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'operator')]"/></h1>
</div>
<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: operator]"/>

    <g:form>
      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: operator, field: 'profile', 'errors')}" required="" size="50" maxlength="80" name="fullName" value="${fieldValue(bean: operator, field: 'profile').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="email"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: operator, field: 'user.email', 'errors')}" required="" size="50" type="text" maxlength="80" name="email" value="${fieldValue(bean: operator, field: 'user.email').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="zip"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: operator, field: 'profile.zip', 'errors')}" size="10" name="zip" value="${fieldValue(bean: operator, field: 'profile.zip').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="city"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: operator, field: 'profile.city', 'errors')}" size="50" name="city" value="${fieldValue(bean: operator, field: 'profile.city').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="street"/></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: operator, field: 'profile.street', 'errors')}" size="50" name="street" value="${fieldValue(bean: operator, field: 'profile.street').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <g:textArea data-counter="2000" class="${hasErrors(bean: operator, field: 'profile.description', 'errors')}" rows="6" cols="50" name="description" value="${fieldValue(bean: operator, field: 'profile.description').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="phone"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean: operator, field: 'profile.phone', 'errors')}" size="25" name="phone" value="${fieldValue(bean: operator, field: 'profile.phone').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="showTips"/></td>
          <td class="value">
            <g:checkBox name="showTips" value="${operator?.profile?.showTips}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="active"/></td>
          <td class="value">
            <g:checkBox name="enabled" value="${operator?.user?.enabled}"/>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link></div>
      </div>
      
    </g:form>

</div>
</body>
