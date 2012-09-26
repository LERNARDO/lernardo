<head>
  <meta name="layout" content="database"/>
  <title><g:message code="groupFamilies"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="groupFamilies"/></h1>
</div>
<div class="boxGray">

  <div class="info-msg">
    <g:message code="object.total" args="[totalGroupFamilies, message(code: 'groupFamilies')]"/>
  </div>

  <erp:accessCheck types="['Betreiber']">
    <div class="buttons cleared">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'groupFamily')])}"/></div>
      </g:form>
    </div>
  </erp:accessCheck>

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'groupFamilyProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField name="name" size="30"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="groupFamily.profile.familyIncome"/></td>
          <td valign="top" class="value">
            <span class="gray"><g:message code="from"/></span> <g:textField name="familyIncomeFrom" size="5"/> <span class="gray"><g:message code="to"/></span> <g:textField name="familyIncomeTo" size="5"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="groupFamily.profile.amountHousehold"/></td>
          <td valign="top" class="value">
            <span class="gray"><g:message code="from"/></span> <g:textField name="amountHouseholdFrom" size="5"/> <span class="gray"><g:message code="to"/></span> <g:textField name="amountHouseholdTo" size="5"/>
          </td>
        </tr>

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
    </g:formRemote>

  </div>

  <div id="searchresults"></div>

</div>
</body>
