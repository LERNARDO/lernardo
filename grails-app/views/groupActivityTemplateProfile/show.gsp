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
            <g:message code="groupActivityTemplateProfile.fullName.label" default="Name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.fullName')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivityTemplateProfile.description.label" default="Beschreibung"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: group, field: 'profile.description')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="groupActivityTemplateProfile.description.label" default="Gesamtdauer"/>:
          </td>
          <td valign="top" class="value"><app:getGroupDuration entity="${group}"/></td>
        </tr>

        <tr class="prop">
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
        </tr>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${group}">
      <div class="buttons">
        <g:link class="buttonBlue" action="edit" id="${group?.id}">Bearbeiten</g:link>
        %{--<g:link class="buttonBlue" action="create">Duplizieren</g:link>--}%
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

  </div>
</div>
</body>
