<head>
  <meta name="layout" content="database"/>
  <title><g:message code="users"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="users"/></h1>
</div>
<div class="boxGray">

  <div class="info-msg">
    <g:message code="object.total" args="[totalUsers, message(code: 'users')]"/>
  </div>

  <div class="buttons">
    <g:form>
      <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'user')])}"/></div>
      <div class="clear"></div>
    </g:form>
  </div>

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'userProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField name="name" size="30"/>
          </td>
        </tr>

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
      <div class="clear"></div>
    </g:formRemote>

  </div>

  <div id="searchresults"></div>

</div>
</body>