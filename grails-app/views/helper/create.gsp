<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="database"/>
  <title><g:message code="object.create" args="[message(code: 'helper')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'helper')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${helperInstance}">
      <div class="errors">
        <g:renderErrors bean="${helperInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form>
      <table width="100%">
        <tbody>

        <tr>
          <td valign="top" class="label"><g:message code="title"/>:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'title', 'errors')}"><g:textField class="countable50" name="title" size="50" value="${fieldValue(bean:helperInstance, field:'title')}"/></td>
        </tr>

        <tr>
          <td class="label"><g:message code="text"/>:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'content', 'errors')}">
            <ckeditor:editor name="content" height="200px" toolbar="Basic">
              ${fieldValue(bean:helperInstance,field:'content').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr>
          <td class="label">Für:</td>
          <td class="value ${hasErrors(bean: helperInstance, field: 'types', 'errors')}">
            <g:select name="types" multiple="true" from="${grailsApplication.config.helpertypes}" value="${helperInstance?.types}" valueMessagePrefix="profiletype"/>
          </td>
        </tr>

        </tbody>
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
