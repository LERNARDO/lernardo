<head>
  <meta name="layout" content="private"/>
  <title>Ressource</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Ressource</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="resource.profile.name"/></td>
          <td valign="top" class="name-show"><g:message code="resource.profile.type"/></td>
        </tr>

        <tr class="prop">
          <td width="540" valign="top" class="value-show">
            ${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}
          </td>
          <td width="340" valign="top" class="value-show">
            ${fieldValue(bean: resource, field: 'profile.type').decodeHTML()}
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name-show"><g:message code="resource.profile.description"/></td>
        </tr>
        <tr>
          <td colspan="2" valign="top" class="value-show-block">
            ${fieldValue(bean: resource, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
          </td>
        </tr>

        </tbody>
      </table>

    </div>
    <div class="buttons">
      <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="[]">
        <g:link class="buttonGreen" action="edit" id="${resource?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonRed" action="del" onclick="${app.getLinks(id: resource.id)}" id="${resource.id}">Löschen</g:link>
      </app:hasRoleOrType>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>
  </div>
</div>
</body>
