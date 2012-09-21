<head>
  <meta name="layout" content="organisation"/>
  <title><g:message code="processes"/></title>
</head>

<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="entries"><g:message code="entries"/></g:link></h1>
  </div>
</div>

%{--<erp:accessCheck types="['Betreiber']" facilities="${facilities}">--}%
  <div class="tabGrey">
    <div class="second">
      <h1><g:link controller="logBook" action="evaluation"><g:message code="evaluation2"/></g:link></h1>
    </div>
  </div>
%{--</erp:accessCheck>--}%

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="processes"/></h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="settings"><g:message code="attendance"/></g:link></h1>
  </div>
</div>

<div class="clear"></div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.total" args="[processes.size(), message(code: 'processes')]"/>
    </div>

    <erp:accessCheck types="['Betreiber']" facilities="${facilities}">
        <div class="buttons cleared">
          <g:form controller="logBook" action="createProcess">
            <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'object.create', args: [message(code: 'process')])}"/></div>
          </g:form>
        </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="name" title="${message(code:'name')}"/>
        <g:sortableColumn property="costs" title="${message(code:'costs')} (${grailsApplication.config.currency})"/>
        <g:sortableColumn property="unit" title="${message(code:'unit')}"/>
      </tr>
      </thead>
      <tbody>
      <g:each in="${processes}" status="i" var="process">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="showProcess" id="${process.id}">${fieldValue(bean: process, field: 'name').decodeHTML()}</g:link></td>
          <td>${process.costs}${grailsApplication.config.currencySymbol}</td>
          <td><g:message code="logunit.${process.unit}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

  </div>
</div>
</body>
