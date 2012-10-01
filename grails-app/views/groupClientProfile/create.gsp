<head>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'groupClient')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'groupClient')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" required="" size="40" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <g:textArea data-counter="2000" class="${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="3" cols="50" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>
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