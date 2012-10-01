<head>
  <meta name="layout" content="administration"/>
  <title><g:message code="object.create" args="[message(code: 'label')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'label')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: labelInstance]"/>

    <g:form>

      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/></td>
          <td class="value">
            <g:textField size="40" data-counter="50" class="${hasErrors(bean: labelInstance, field: 'name', 'errors')}" name="name" value="${fieldValue(bean: labelInstance, field: 'name').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="description"/></td>
          <td class="value">
            <g:textArea rows="4" cols="50" data-counter="5000" class="${hasErrors(bean: labelInstance, field: 'description', 'errors')}" name="description" value="${fieldValue(bean: labelInstance, field: 'description').decodeHTML()}"/>
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
