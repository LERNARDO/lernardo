<head>
  <meta name="layout" content="database"/>
  <title><g:message code="paten"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="paten"/></h1>
</div>
<div class="boxContent">

  <div class="info-msg">
    <g:message code="object.total" args="[totalPates, message(code: 'paten')]"/>
  </div>

  <erp:accessCheck types="['Betreiber']">
    <div class="buttons cleared">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'pate')])}"/></div>
      </g:form>
    </div>
  </erp:accessCheck>

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'pateProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

      <table>

        <tr class="prop">
          <td class="name"><g:message code="active"/></td>
          <td class="value">
            <g:checkBox name="active" value="true"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="name"/></td>
          <td class="value">
            <g:textField name="name" size="30"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="country"/></td>
          <td class="value">
            <g:select name="country" from="${nationalities}" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

          <tr class="prop">
              <td class="name"><g:message code="client"/></td>
              <td class="value">
                  <g:textField name="client" size="30"/>
              </td>
          </tr>

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
    </g:formRemote>

  </div>

  <div id="searchresults"></div>

</div>
</body>