<head>
  <meta name="layout" content="administration"/>
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
        <g:form id="${workdayCategoryInstance?.id}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <erp:accessCheck entity="${currentEntity}">
            <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" /></div>
          </erp:accessCheck>
          <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
        </g:form>
        <div class="spacer"></div>
      </div>
    </erp:accessCheck>

  </div>
</div>
</body>
