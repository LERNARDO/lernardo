<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupColonies"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="groupColonies"/></h1>
</div>
<div class="boxGray">

  <div class="info-msg">
    <g:message code="object.total" args="[totalGroupColonies, message(code: 'groupColonies')]"/>
  </div>

  <erp:accessCheck types="['Betreiber']">
    <div class="buttons cleared">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'groupColony')])}"/></div>
      </g:form>
    </div>
  </erp:accessCheck>

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'groupColonyProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField name="name" size="30"/>
          </td>
        </tr>

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
    </g:formRemote>

  </div>

  <div id="searchresults"></div>

</div>
</body>
