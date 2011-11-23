<head>
  <meta name="layout" content="private"/>
  <title><g:message code="process"/> - ${process.name}</title>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="process"/> - ${process.name}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>
      <table style="width: 100%">

        <tr>
          <td valign="top" class="name-show"><g:message code="name"/></td>
          <td valign="top" class="name-show"><g:message code="costs"/> (${grailsApplication.config.currency})</td>
          <td valign="top" class="name-show"><g:message code="unit"/></td>
          <td valign="top" class="name-show"><g:message code="facilities"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show"><g:link action="showProcess" id="${process.id}">${process.name.decodeHTML()}</g:link></td>
          <td valign="top" class="value-show">${process.costs}</td>
          <td valign="top" class="value-show"><g:message code="logunit.${process.unit}"/></td>
          <td valign="top" class="value-show-block">
            <g:if test="${process.facilities}">
            <ul>
              <g:each in="${process.facilities}" var="facility">
                <li>${facility.profile.fullName.decodeHTML()}</li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
          </td>
        </tr>

        <tr>
          <td valign="top" class="name-show"><g:message code="types"/></td>
          <td valign="top" class="name-show"><g:message code="users"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show-block">
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
          <td valign="top" class="value-show-block">
            <g:if test="${process.entities}">
            <ul>
              <g:each in="${process.entities}" var="entity">
                <li><erp:getEntity entity="${entity}"><g:link controller="${result.type.supertype.name +'Profile'}" action="show" id="${result.id}" params="[entity:result.id]">${result.profile.fullName}</g:link></erp:getEntity></li>
              </g:each>
            </ul>
          </g:if>
          <g:else>
            <div class="italic">${message(code: 'noData')}</div>
          </g:else>
          </td>
        </tr>

      </table>


      <div class="buttons">
        <g:form id="${process.id}">
          <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" facilities="${facilities}">
            <div class="button"><g:actionSubmit class="buttonGreen" action="editProcess" value="${message(code: 'edit')}" /></div>
            %{--<div class="button"><g:actionSubmit class="buttonRed" action="deleteProcess" value="${message(code: 'delete')}" /></div>--}%
          </erp:accessCheck>
          <div class="button"><g:actionSubmit class="buttonGray" action="processes" value="${message(code: 'back')}" /></div>
        </g:form>
        <div class="spacer"></div>
      </div>

    </div>
  </div>
</div>
</body>
