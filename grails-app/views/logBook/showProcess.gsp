<head>
  <meta name="layout" content="organisation"/>
  <title><g:message code="process"/> - ${process.name}</title>
</head>

<body>
<div class="boxHeader">
  <h1><g:message code="process"/> - ${process.name}</h1>
</div>
<div class="boxContent">

    <table>
      <tbody>

      <tr class="prop">
        <td class="one"><g:message code="name"/></td>
        <td class="two"><g:link action="showProcess" id="${process.id}">${process.name.decodeHTML()}</g:link></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="costs"/> (${grailsApplication.config.currency})</td>
        <td class="two">${process.costs}</td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="unit"/></td>
        <td class="two"><g:message code="logunit.${process.unit}"/></td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="facilities"/></td>
        <td class="two">
          <g:if test="${process.facilities}">
            <ul>
              <g:each in="${process.facilities}" var="facility">
                <li>${facility.profile.decodeHTML()}</li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
        </td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="usertypes"/></td>
        <td class="two">
          <g:if test="${process.types}">
            <ul>
              <g:each in="${process.types}" var="type">
                <li><g:message code="profiletype.${type}"/></li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
        </td>
      </tr>

      <tr class="prop">
        <td class="one"><g:message code="directSelection"/></td>
        <td class="two">
          <g:if test="${process.entities}">
            <ul>
              <g:each in="${process.entities}" var="entity">
                <li><erp:getEntity entity="${entity}"><g:link controller="${result.type.supertype.name + 'Profile'}" action="show" id="${result.id}">${result.profile.decodeHTML()}</g:link></erp:getEntity></li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
        </td>
      </tr>

      </tbody>
    </table>

    <div class="buttons cleared">
      <g:form id="${process.id}">
        <erp:accessCheck types="['Betreiber']" facilities="${facilities}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="editProcess" value="${message(code: 'edit')}" /></div>
          %{--<div class="button"><g:actionSubmit class="buttonRed" action="deleteProcess" value="${message(code: 'delete')}" /></div>--}%
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="processes" value="${message(code: 'back')}" /></div>
      </g:form>
    </div>

</div>
</body>
