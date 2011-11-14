<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.create" args="[message(code: 'label')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'label')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: labelInstance]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField size="40" class="countable50 ${hasErrors(bean: labelInstance, field: 'name', 'errors')}" name="name" value="${fieldValue(bean: labelInstance, field: 'name').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <g:textArea rows="4" cols="50" class="countable5000 ${hasErrors(bean: labelInstance, field: 'description', 'errors')}" name="description" value="${fieldValue(bean: labelInstance, field: 'description').decodeHTML()}"/>
          </td>
        </tr>

      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
