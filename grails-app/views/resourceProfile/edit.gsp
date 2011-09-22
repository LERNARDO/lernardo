<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.edit" args="[message(code: 'resource')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'resource')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: resource]"/>

    <g:form action="update" id="${resource?.id}">
      <div>
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
          </tr>

          <tr class="prop">
            <td width="540" valign="top" class="value">
              <g:textField class="countable${resource.profile.constraints.fullName.maxSize} ${hasErrors(bean: resource, field: 'profile.fullName', 'errors')}" size="80" maxlength="80" name="fullName" value="${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="description"/></td>
          </tr>
          <tr>
            <td valign="top" class="value">
              <g:textArea class="countable${resource.profile.constraints.description.maxSize} ${hasErrors(bean: resource, field: 'profile.description', 'errors')}" rows="3" cols="120" name="description" value="${fieldValue(bean: resource, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="resource.profile.amount"/></td>
          </tr>

          <tr class="prop">
            <td width="540" valign="top" class="value">
              <g:textField class="${hasErrors(bean: resource, field: 'profile.amount', 'errors')}" size="5" maxlength="5" name="amount" value="${fieldValue(bean: resource, field: 'profile.amount')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="resource.profile.costs"/></td>
          </tr>

          <tr class="prop">
            <td width="540" valign="top" class="value">
              <g:textField class="${hasErrors(bean: resource, field: 'profile.costs', 'errors')}" size="5" maxlength="5" name="costs" value="${fieldValue(bean: resource, field: 'profile.costs')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="resource.profile.costsUnit"/></td>
          </tr>

          <tr class="prop">
            <td width="540" valign="top" class="value">
              <g:select name="costsUnit" from="${grailsApplication.config.costsUnit}" value="" valueMessagePrefix="costsUnit"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="resource.profile.classification"/></td>
          </tr>

          <tr class="prop">
            <td width="540" valign="top" class="value">
              <g:select name="classification" from="${grailsApplication.config.resourceclasses}" value="" valueMessagePrefix="resourceclass"/>
            </td>
          </tr>

          </tbody>
        </table>

      </div>

      <div class="buttons">
        <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code:'save')}"/></div>
        <g:link class="buttonGray" action="show" id="${resource?.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
