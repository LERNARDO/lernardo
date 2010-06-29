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
              <label for="fullName">
                <g:message code="groupActivityTemplate.profile.name"/>
              </label>
            </td>
            <td valign="top" class="name-show">
              <label for="realDuration">
                <g:message code="groupActivityTemplate.profile.realDuration"/>
              </label>
            </td>
            <td valign="top" class="name-show">
              <label for="status">
                <g:message code="groupActivityTemplate.profile.status"/>
              </label>
            </td>
            </tr>
          <tr>
            
            <td width="500px" valign="top" class="value-show"><g:link controller="${group.type.supertype.name+'Profile'}" action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link>
            </td>

            <td width="170px" valign="top" class="value-show">
              ${fieldValue(bean: group, field: 'profile.realDuration')} min
            </td>
             <td valign="top" class="value-show">
              ${fieldValue(bean: group, field: 'profile.status').decodeHTML()}
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name">
              <label for="description">
                <g:message code="groupActivityTemplate.profile.description"/>
              </label>
            </td>
          </tr>
           <tr>
            <td colspan="3" height="60" valign="top" class="value-show-block">
              ${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
            </td>
          </tr>
        </table>

      
    </div>

    <app:isMeOrAdmin entity="${entity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="list">Zurück zur Liste</g:link>
        <g:link class="buttonGreen" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        %{--<g:link class="buttonBlue" action="create">Duplizieren</g:link>--}%

        <app:isEducator entity="${entity}">
          %{-- and only when it is done --}%
          <g:if test="${group.profile.status == 'fertig'}">
            <g:link class="buttonGreen" controller="groupActivityProfile" action="create" id="${group.id}">Aktivitätsblock instanzieren</g:link>
          </g:if>
        </app:isEducator>

        <g:link class="buttonGreen" action="create" id="${group.id}">Vorlage duplizieren</g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div class="zusatz">
      <h5>Aktivitätsvorlagen <app:isEducator entity="${entity}"><a href="#" id="show-templates"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Aktivitätsvorlage hinzufügen" /></a></app:isEducator></h5>
      <jq:jquery>
        <jq:toggle sourceId="show-templates" targetId="templates"/>
      </jq:jquery>
      <div class="zusatz-add" id="templates" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupActivityTemplateProfile', action:'addTemplate', id:group.id]" update="templates2" before="hideform('#templates')">
          <g:select name="template" from="${allTemplates}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="templates2">
        <g:render template="templates" model="[group: group, entity: entity, templates: templates]"/>
      </div>
    </div>

  </div>
</div>

<g:render template="/comment/box" model="[entity: entity, commented: group]"/>

</body>
