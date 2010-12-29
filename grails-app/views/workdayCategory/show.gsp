<head>
  <meta name="layout" content="private"/>
  <title><g:message code="user"/> - ${workdayCategoryInstance.name}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="workdayCategory"/> - ${workdayCategoryInstance.name}</h1>
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">

    <table>
      <tbody>

      <tr class="prop">
        <td class="one"><g:message code="workdayCategory.name"/>:</td>
        <td class="two">${fieldValue(bean: workdayCategoryInstance, field: 'name').decodeHTML()}</td>
      </tr>

      </tbody>
    </table>

    <erp:isOperator entity="${currentEntity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${workdayCategoryInstance?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:isOperator>

  </div>
</div>
</body>
