<head>
  <meta name="layout" content="private"/>
  <title><g:message code="method.create"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="method.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: methodInstance]"/>

    <g:form>
      <div>
        <table>
          <tbody>

          <tr class="prop">
            <td  valign="top" class="name"><g:message code="method.name"/></td>
            <td valign="top" class="name"><g:message code="method.description"/></td>
          </tr>

          <tr class="prop">
            <td width="280" valign="top" class="value">
              <g:textField size="40" class="countable50 ${hasErrors(bean: methodInstance, field: 'name', 'errors')}" name="name" value="${fieldValue(bean: methodInstance, field: 'name').decodeHTML()}"/>
            </td>
            <td  width="400" valign="top" class="value">
              <g:textArea rows="3" cols="80" class="countable2000 ${hasErrors(bean: methodInstance, field: 'description', 'errors')}" name="description" value="${fieldValue(bean: methodInstance, field: 'description').decodeHTML()}"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
