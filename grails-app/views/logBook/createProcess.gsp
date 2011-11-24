<head>
  <title><g:message code="object.create" args="[message(code: 'process')]"/></title>
  <meta name="layout" content="private"/>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'process')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

  <g:hasErrors bean="${process}">
    <div class="errors">
      <g:renderErrors bean="${process}" as="list"/>
    </div>
  </g:hasErrors>

  <g:form action="saveProcess" id="${process.id}">

    <table>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="name"/></td>
        <td valign="top" class="value">
          <g:textField class="countable50 ${hasErrors(bean: process, field: 'name', 'errors')}" name="name" size="50" value="${fieldValue(bean:process,field:'name').decodeHTML()}"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="costs"/> (${grailsApplication.config.currency})</td>
        <td valign="top" class="value">
          <g:textField class="countable50 ${hasErrors(bean: process, field: 'costs', 'errors')}" name="costs" size="10" value="${fieldValue(bean:process,field:'costs').decodeHTML()}"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="unit"/></td>
        <td valign="top" class="value">
          <g:select name="unit" from="['perDay','perMonth']" value="${process.unit}" valueMessagePrefix="logunit"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="facilities"/></td>
        <td valign="top" class="value">
          <g:select name="facilities" from="${facilities}" optionKey="id" optionValue="profile" multiple="true" value="${process.facilities}"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="types"/></td>
        <td valign="top" class="value">
          <g:select name="types" from="['educator','leadEducator','operator']" multiple="true" valueMessagePrefix="profiletype" value="${process.types}"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="users"/></td>
        <td valign="top" class="value">
          <g:select name="entities" from="${entities}" multiple="true" optionKey="id" optionValue="profile" value="${currentEntities}"/>
        </td>
      </tr>

    </table>

    <div class="buttons">
      <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code:'save')}" /></div>
      <g:link class="buttonGray" action="processes"><g:message code="cancel"/></g:link>
      <div class="spacer"></div>
    </div>

  </g:form>
  </div>
</div>
</body>