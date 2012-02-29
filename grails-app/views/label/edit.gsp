<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="object.edit" args="[message(code: 'label')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'label')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${labelInstance}">
      <div class="errors">
        <g:renderErrors bean="${labelInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form id="${labelInstance.id}">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField size="40" class="countable${labelInstance.constraints.name.maxSize} ${hasErrors(bean: labelInstance, field: 'name', 'errors')}" name="name" value="${fieldValue(bean: labelInstance, field: 'name').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <g:textArea rows="4" cols="50" class="countable${labelInstance.constraints.description.maxSize} ${hasErrors(bean: labelInstance, field: 'description', 'errors')}" name="description" value="${fieldValue(bean: labelInstance, field: 'description').decodeHTML()}"/>
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