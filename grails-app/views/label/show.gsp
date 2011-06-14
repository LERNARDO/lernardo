<head>
  <meta name="layout" content="private"/>
  <title><g:message code="profile"/> - ${labelInstance.name}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile"/> - ${labelInstance.name}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="label.name"/>:
          </td>
           <td valign="top" class="name-show">
            <g:message code="label.description"/>:
          </td>

        </tr>

        <tr class="prop">
         <td width="280" valign="top" class="value-show">${fieldValue(bean: labelInstance, field: 'name').decodeHTML()}</td>
          <td width="480" valign="top" class="value-show-block">${fieldValue(bean: labelInstance, field: 'description').decodeHTML() ?: '<div class="italic">'+message(code:'noData')+'</div>'}</td>
        </tr>

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <g:form id="${labelInstance.id}">
        <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>