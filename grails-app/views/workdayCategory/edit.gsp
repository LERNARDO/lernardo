<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="object.edit" args="[message(code: 'workdayCategory')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1 style="float: left"><g:message code="object.edit" args="[message(code: 'workdayCategory')]"/></h1>
  <div class="icons" style="text-align: right;">
    <g:link action="show" id="${workdayCategoryInstance.id}"><img src="${resource(dir: 'images/icons', file: 'icon_cancel.png')}" alt="${message(code: 'cancel')}" align="top"/></g:link>
  </div>
</div>
<div class="boxContent" style="clear: both;">

    <g:render template="/templates/errors" model="[bean: workdayCategoryInstance]"/>

    <g:form id="${workdayCategoryInstance.id}">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="workdayCategory.name"/></td>
          <td class="value">
            <g:textField class="${hasErrors(bean:workdayCategoryInstance,field:'name','errors')}" size="50" name="name" value="${fieldValue(bean:workdayCategoryInstance,field:'name').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="workdayCategory.count"/></td>
          <td class="value">
            <g:checkBox name="counts" value="${workdayCategoryInstance?.counts}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="begin"/></td>
          <td class="value">
            <g:textField name="beginDate" class="datepicker ${hasErrors(bean: workdayCategoryInstance, field: 'beginDate', 'errors')}" value="${formatDate(date: workdayCategoryInstance.beginDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="end"/></td>
          <td class="value">
            <g:textField name="endDate" class="datepicker ${hasErrors(bean: workdayCategoryInstance, field: 'endDate', 'errors')}" value="${formatDate(date: workdayCategoryInstance.endDate, format: 'dd. MM. yyyy')}"/>
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