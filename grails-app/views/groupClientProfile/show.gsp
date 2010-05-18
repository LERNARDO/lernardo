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
                   <g:message code="groupClient.profile.name" />:
                </td>
              <td valign="top" class="value">${fieldValue(bean:group, field:'profile.fullName').decodeHTML()}</td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                   <g:message code="groupClient.profile.description" />:
                </td>
                <td valign="top" class="value">${fieldValue(bean:group, field:'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>                           
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
      <h1>Betreute <app:isMeOrAdmin entity="${group}"><a href="#" id="show-clients"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Betreute hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-clients" targetId="clients"/>
      </jq:jquery>
      <div id="clients" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupClientProfile', action:'addClient', id:group.id]" update="clients2" before="hideform('#clients')">
          <g:select name="client" from="${allClients}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="clients2">
        <g:render template="clients" model="[clients: clients, group: group]"/>
      </div>
    </div>

  </div>
</div>
</body>