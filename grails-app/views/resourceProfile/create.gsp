<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.create" args="[message(code: 'resource')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'resource')]"/></h1>
</div>
<div class="boxGray">

    <g:render template="/templates/errors" model="[bean: resourceInstance]"/>

    <g:form action="save">
      <div>
        <table>
          <tbody>

          <tr class="prop">
            <td class="name"><g:message code="name"/></td>
          </tr>

          <tr class="prop">
            <td class="value">
              <g:textField data-counter="50" class="${hasErrors(bean: resourceInstance, field: 'profile.fullName', 'errors')}" size="80" name="fullName" value="${fieldValue(bean: resourceInstance, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td class="name"><g:message code="description"/></td>
          </tr>
          <tr>
            <td class="value">
              <g:textArea data-counter="2000" class="${hasErrors(bean: resourceInstance, field: 'profile.description', 'errors')}" rows="3" cols="120" name="description" value="${fieldValue(bean: resourceInstance, field: 'profile.description')}"/>
            </td>
          </tr>

          <g:hiddenField name="classification" value=""/>

          </tbody>
        </table>
      </div>

      <div class="buttons cleared">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
      </div>
      
    </g:form>

</div>
</body>
