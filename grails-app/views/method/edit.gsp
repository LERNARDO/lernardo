<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="object.edit" args="[message(code: 'method')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.edit" args="[message(code: 'method')]"/></h1>
</div>
<div class="boxGray">

    <g:hasErrors bean="${methodInstance}">
      <div class="errors">
        <g:renderErrors bean="${methodInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form id="${methodInstance.id}">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/></td>
          <td class="value">
            <g:textField size="50" data-counter="50" class="${hasErrors(bean: methodInstance, field: 'name', 'errors')}" name="name" value="${fieldValue(bean: methodInstance, field: 'name').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <g:textArea rows="4" cols="50" data-counter="5000" class="${hasErrors(bean: methodInstance, field: 'description', 'errors')}" name="description" value="${fieldValue(bean: methodInstance, field: 'description').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
      </div>

    </g:form>

</div>
</body>