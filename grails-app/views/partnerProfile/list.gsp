<head>
  <meta name="layout" content="database"/>
  <title><g:message code="partner"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="partner"/></h1>
</div>
<div class="boxContent">

  <div class="info-msg">
    <g:message code="object.total" args="[totalPartners, message(code: 'partners')]"/>
  </div>

  <erp:accessCheck types="['Betreiber']">
    <div class="buttons cleared">
      <g:form>
        <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'partner')])}"/></div>
      </g:form>
    </div>
  </erp:accessCheck>

  <div class="graypanel">

    <g:formRemote name="formRemote" url="[controller: 'partnerProfile', action: 'define']" update="searchresults" before="showspinner('#searchresults')">

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
          <td class="name"><g:message code="partner.profile.services"/></td>
          <td class="value">
            <g:select name="services" multiple="true" from="${partnerServices}" noSelection="['': message(code: 'all')]"/>
          </td>
        </tr>

      </table>

      <g:submitButton name="button" value="${message(code:'define')}"/>
    </g:formRemote>

  </div>

  <div id="searchresults"></div>

</div>
</body>