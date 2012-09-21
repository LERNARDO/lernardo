<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'helper')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'helper')]"/></h1>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${helperInstance}">
      <div class="errors">
        <g:renderErrors bean="${helperInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form>

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="title"/></td>
          <td valign="top" class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: helperInstance, field: 'title', 'errors')}" name="title" size="50" value="${fieldValue(bean:helperInstance, field:'title')}"/>
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

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
      </div>

    </g:form>
  </div>
</div>
</body>
