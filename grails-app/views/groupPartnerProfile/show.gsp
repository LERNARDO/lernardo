<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>

        <tr class="prop">
          <td valign="top" class="name-show">
            <g:message code="groupPartner.profile.name"/>:
          </td>
          <td valign="top" class="name-show">
            <g:message code="groupPartner.profile.description"/>:
          </td>
        </tr>
        <tr class="prop">
          <td width="200" valign="top" class="value-show">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
          <td width="500" valign="top" class="value-show-block">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show">&nbsp;</td>
          <td valign="top" class="name-show">
            <g:message code="groupPartner.profile.service"/>:
          </td>
        </tr>
        <tr class="prop">
          <td valign="top" class="name-show">&nbsp;</td>
          <td valign="top" class="value-show"><li><app:getPartnerService service="${group.profile.service}"/></li></td>
        </tr>

      </table>
    </div>

    <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:hasRoleOrType>

    <div class="zusatz">
      <h5>Partner <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']"><a href="#" id="show-partners"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Partner hinzufügen"/></a></app:hasRoleOrType></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-partners" targetId="partners"/>
      </jq:jquery>
      <div class="zusatz-add" id="partners" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupPartnerProfile', action:'addPartner', id:group.id]" update="partners2" before="showspinner('#partners2')">
          <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="partners2">
        <g:render template="partners" model="[partners: partners, group: group]"/>
      </div>
    </div>

  </div>
</div>
</body>