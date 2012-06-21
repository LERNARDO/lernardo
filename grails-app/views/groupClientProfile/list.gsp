<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupClients"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="groupClients"/></h1>
</div>
<div class="boxGray">

  <div class="info-msg">
    <g:message code="object.total" args="[totalGroupClients, message(code: 'groupClients')]"/>
  </div>

  <erp:accessCheck types="['Betreiber', 'Pädagoge']">
    <div class="buttons">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'groupClient')])}"/></div>
        <div class="clear"></div>
      </g:form>
    </div>
  </erp:accessCheck>

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'groupClientProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

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
