<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="object.create" args="[message(code: 'workdayCategory')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'workdayCategory')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: workdayCategoryInstance]"/>
    <g:form>

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="workdayCategory.name"/></td>
          <td valign="top" class="value">
            <g:textField data-counter="50" class="${hasErrors(bean:workdayCategoryInstance,field:'name','errors')}" size="50" name="name" value="${fieldValue(bean:workdayCategoryInstance,field:'name').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="workdayCategory.count"/></td>
          <td valign="top" class="value">
            <g:checkBox name="counts" value="${fieldValue(bean:workdayCategoryInstance,field:'counts')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="begin"/></td>
          <td valign="top" class="value">
            <g:textField name="beginDate" class="datepicker ${hasErrors(bean: workdayCategoryInstance, field: 'beginDate', 'errors')}" value="${formatDate(date: workdayCategoryInstance.beginDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="end"/></td>
          <td valign="top" class="value">
            <g:textField name="endDate" class="datepicker ${hasErrors(bean: workdayCategoryInstance, field: 'endDate', 'errors')}" value="${formatDate(date: workdayCategoryInstance.endDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
      </div>

    </g:form>
  </div>
</div>
</body>