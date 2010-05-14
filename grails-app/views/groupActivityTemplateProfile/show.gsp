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
            <g:message code="groupActivityTemplate.profile.name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivityTemplate.profile.description"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.description').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivityTemplate.profile.realDuration"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivityTemplate.profile.status"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.status').decodeHTML()}</td>
        </tr>

%{--        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivityTemplate.profile.realDuration"/>:
          </td>
          <td valign="top" class="value"><app:getGroupDuration entity="${group}"/></td>
        </tr>--}%

%{--        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivityTemplateProfile.dateCreated.label" default="Ersteller"/>:
          </td>
          <td valign="top" class="value"><app:getCreator entity="${group}">${creator.profile.fullName}</app:getCreator></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivityTemplateProfile.lastUpdated.label" default="Letzter Bearbeiter"/>:
          </td>
          <td valign="top" class="value"><app:getEditor entity="${group}">${editor.profile.fullName}</app:getEditor></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivityTemplateProfile.lastUpdated.label" default="Aktivitätsvorlagen"/>:
          </td>
          <td valign="top" class="value"><app:getGroup entity="${group}"><ul><g:each in="${members}" var="member"><li><g:link controller="template" action="show" id="${member.id}">${member.profile.fullName}</g:link></li></g:each></ul></app:getGroup></td>
        </tr>--}%

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${group}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        %{--<g:link class="buttonBlue" action="create">Duplizieren</g:link>--}%
        <g:link class="buttonBlue" controller="groupActivityProfile" action="create" id="${group.id}">Neue Aktivitätsgruppe planen</g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <div>
      <h1>Aktivitätsvorlagen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-templates"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Aktivitätsvorlage hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-templates" targetId="templates"/>
      </jq:jquery>
      <div id="templates" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'groupActivityTemplateProfile', action:'addTemplate', id:group.id]" update="templates2" before="hideform('#templates')">
          <g:select name="template" from="${allTemplates}" optionKey="id" optionValue="profile"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="templates2">
        <g:render template="templates" model="[group: group, entity: entity, templates: templates]"/>
      </div>
    </div>

  </div>
</div>
</body>
