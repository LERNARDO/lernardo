<head>
  <meta name="layout" content="private"/>
  <title><g:message code="resource"/> - ${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="resource"/> - ${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="location"/></td>
        </tr>

        <tr class="prop">
          <td width="540" valign="top" class="value-show">
            <g:link controller="${location.type.supertype.name +'Profile'}" action="show" id="${location.id}" params="[entity: location.id]">${fieldValue(bean: location, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="resource.profile.name"/></td>
        </tr>

        <tr class="prop">
          <td width="540" valign="top" class="value-show">
            ${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name-show"><g:message code="resource.profile.description"/></td>
        </tr>
        <tr>
          <td colspan="2" valign="top" class="value-show-block">
            ${fieldValue(bean: resource, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name-show"><g:message code="resource.profile.amount"/></td>
        </tr>
        <tr>
          <td colspan="2" valign="top" class="value-show-block">
            ${fieldValue(bean: resource, field: 'profile.amount')}
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name-show"><g:message code="resource.profile.free"/></td>
        </tr>
        <tr>
          <td colspan="2" valign="top" class="value-show-block">
            ${fieldValue(bean: resource, field: 'profile.free')}
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name-show"><g:message code="resource.profile.costs"/> <span class="gray">(${grailsApplication.config.currency})</span></td>
        </tr>
        <tr>
          <td colspan="2" valign="top" class="value-show-block">
            ${fieldValue(bean: resource, field: 'profile.costs')}
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name-show"><g:message code="resource.profile.costsUnit"/></td>
        </tr>
        <tr>
          <td colspan="2" valign="top" class="value-show-block">
            <g:message code="costsUnit.${resource.profile.costsUnit}"/>
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name-show"><g:message code="resource.profile.classification"/></td>
        </tr>
        <tr>
          <td colspan="2" valign="top" class="value-show-block">
            <g:message code="resourceclass.${resource.profile.classification}"/>
          </td>
        </tr>

        </tbody>
      </table>

    </div>

    <div class="buttons">
      <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
        <g:link class="buttonGreen" action="edit" id="${resource?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonRed" action="del" onclick="${erp.getLinks(id: resource.id)}" id="${resource.id}"><g:message code="delete"/></g:link>
      </erp:accessCheck>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>
