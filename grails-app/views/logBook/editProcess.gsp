<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.edit" args="[message(code: 'process')]"/></title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.edit" args="[message(code: 'process')]"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: process]"/>

    <g:form action="updateProcess" id="${process.id}">

    <p><span class="strong"><g:message code="name"/></span><br/>
    <span class="${hasErrors(bean: process, field: 'name', 'errors')}"><g:textField class="countable50" name="name" size="50" value="${fieldValue(bean:process,field:'name').decodeHTML()}"/></span></p>

    <p><span class="strong"><g:message code="costs"/> (${grailsApplication.config.currency})</span><br/>
    <span class="${hasErrors(bean: process, field: 'costs', 'errors')}"><g:textField class="countable50" name="costs" size="10" value="${fieldValue(bean:process,field:'costs').decodeHTML()}"/></span></p>

    <span class="strong"><g:message code="facilities"/></span><br/>
    <g:select name="facilities" from="${facilities}" optionKey="id" optionValue="profile" multiple="true" value="${process.facilities}"/>

    <div class="buttons">
      <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="${message(code:'save')}" /></div>
      <g:link class="buttonGray" action="processes"><g:message code="cancel"/></g:link>
      <div class="spacer"></div>
    </div>

  </g:form>
  </div>
</div>
</body>
