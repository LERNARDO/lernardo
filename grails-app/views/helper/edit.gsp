<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="database"/>
  <title><g:message code="object.edit" args="[message(code: 'helper')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'helper')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${helperInstance}">
      <div class="errors">
        <g:renderErrors bean="${helperInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form id="${helperInstance?.id}">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="title"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: helperInstance, field: 'title', 'errors')}" name="title" size="50" value="${fieldValue(bean:helperInstance, field:'title')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="text"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="content" height="200px" toolbar="Basic">
              ${fieldValue(bean:helperInstance,field:'content').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="for2"/></td>
          <td valign="top" class="value">
            <g:select name="types" multiple="true" from="${grailsApplication.config.helpertypes}" value="${helperInstance?.types}" valueMessagePrefix="profiletype"/>
          </td>
        </tr>

      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="clear"></div>
      </div>

    </g:form>
  </div>
</div>
</body>
