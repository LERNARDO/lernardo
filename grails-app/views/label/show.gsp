<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="label"/> - ${labelInstance.name}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="label"/> - ${labelInstance.name}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <table>

      <tr class="prop">
        <td class="one"><g:message code="name"/>:</td>
        <td class="two">${fieldValue(bean: labelInstance, field: 'name').decodeHTML()}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="description"/>:</td>
        <td class="two">${fieldValue(bean: labelInstance, field: 'description').decodeHTML() ?: '<div class="italic">'+message(code:'noData')+'</div>'}</td>
      </tr>

    </table>

    <div class="buttons">
      <g:form id="${labelInstance.id}">
        <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
      </g:form>
      <div class="clear"></div>
    </div>

  </div>
</div>
</body>