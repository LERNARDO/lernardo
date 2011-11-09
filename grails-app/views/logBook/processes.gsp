<head>
  <meta name="layout" content="private"/>
  <title>Vorgänge</title>
</head>

<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="entries">Einträge</g:link></h1>
  </div>
</div>

<erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities}">
  <div class="tabGrey">
    <div class="second">
      <h1><g:link controller="logBook" action="evaluation">Auswertung</g:link></h1>
    </div>
  </div>
</erp:accessCheck>

<div class="tabGreen">
  <div class="second">
    <h1>Vorgänge</h1>
  </div>
</div>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="logBook" action="settings">Anwesenheit</g:link></h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities}">
        <div class="buttons">
          <g:form controller="logBook" action="createProcess">
            <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'object.create', args: [message(code: 'process')])}"/></div>
            <div class="spacer"></div>
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
          <td>${process.costs}€</td>
          <td><g:message code="logunit.${process.unit}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

  </div>
</div>
</body>
