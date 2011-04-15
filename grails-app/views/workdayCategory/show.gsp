<head>
  <meta name="layout" content="private"/>
  <title><g:message code="user"/> - ${workdayCategoryInstance.name}</title>
</head>
<body>
<div class="boxHeader">
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

      <tr class="prop">
        <td class="one"><g:message code="workdayCategory.count"/>:</td>
        <td class="two"><g:formatBoolean boolean="${workdayCategoryInstance.count}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
      </tr>

      </tbody>
    </table>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${workdayCategoryInstance?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonRed" action="del" id="${workdayCategoryInstance?.id}"><g:message code="delete"/></g:link>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
        <div class="spacer"></div>
      </div>
    </erp:accessCheck>

  </div>
</div>
</body>
