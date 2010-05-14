<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profil - ${group.profile.fullName}</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Profil - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>
                    
          <tr class="prop">
              <td valign="top" class="name">
                 <g:message code="groupPartner.profile.name" />:
              </td>
              <td valign="top" class="value">${fieldValue(bean:group, field:'profile.fullName').decodeHTML()}</td>
          </tr>

          <tr class="prop">
              <td valign="top" class="name">
                 <g:message code="groupPartner.profile.description" />:
              </td>
              <td valign="top" class="value">${fieldValue(bean:group, field:'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
          </tr>

          <tr class="prop">
              <td valign="top" class="name">
                 <g:message code="groupPartner.profile.service" />:
              </td>
              <td valign="top" class="value">${fieldValue(bean:group, field:'profile.service')}</td>                         
          </tr>
                    
        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${group}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h1>Partner <app:isMeOrAdmin entity="${group}"><a href="#" id="show-partners"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Partner hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-partners" targetId="partners"/>
      </jq:jquery>
      <div id="partners" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupPartnerProfile', action:'addPartner', id:group.id]" update="partners2" before="hideform('#partners')">
          <g:select name="partner" from="${allPartners}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="partners2">
        <g:render template="partners" model="[partners: partners, group: group]"/>
      </div>
    </div>

  </div>
</div>
</body>