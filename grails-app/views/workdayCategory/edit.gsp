<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.edit" args="[message(code: 'workdayCategory')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1 style="float: left"><g:message code="object.edit" args="[message(code: 'workdayCategory')]"/></h1>
    <div class="icons" style="text-align: right;">
      <g:link action="show" id="${workdayCategoryInstance.id}"><img src="${resource(dir: 'images/icons', file: 'icon_cancel.png')}" alt="${message(code: 'cancel')}" align="top"/></g:link>
    </div>
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: workdayCategoryInstance]"/>

    <g:form id="${workdayCategoryInstance.id}">

      <div>
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="workdayCategory.name"/></td>
          </tr>

          <tr class="prop">
            <td width="440" valign="top" class="value">
              <g:textField class="${hasErrors(bean:workdayCategoryInstance,field:'name','errors')}" size="50" name="name" value="${fieldValue(bean:workdayCategoryInstance,field:'name').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="workdayCategory.count"/></td>
          </tr>

          <tr class="prop">
            <td width="440" valign="top" class="value">
              <g:checkBox name="count" value="${fieldValue(bean:workdayCategoryInstance,field:'count')}"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>