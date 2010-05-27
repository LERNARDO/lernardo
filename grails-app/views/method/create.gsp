<head>
  <meta name="layout" content="private"/>
  <title>Bewertungsmethode anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Bewertungsmethode anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${methodInstance}">
      <div class="errors">
        <g:renderErrors bean="${methodInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="name">
                <g:message code="method.name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField size="40" class="${hasErrors(bean: methodInstance, field: 'name', 'errors')}" id="name" name="name" value="${fieldValue(bean: methodInstance, field: 'name').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="method.description"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea rows="5" cols="50" class="${hasErrors(bean: methodInstance, field: 'description', 'errors')}" id="description" name="description" value="${fieldValue(bean: methodInstance, field: 'description').decodeHTML()}"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
