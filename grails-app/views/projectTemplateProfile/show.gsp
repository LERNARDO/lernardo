<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Projektvorlage</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Projektvorlage</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="projectTemplate.profile.name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="projectTemplate.profile.description"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: projectTemplate, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="projectTemplate.profile.status"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: projectTemplate, field: 'profile.status')}</td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <g:link class="buttonBlue" action="edit" id="${projectTemplate?.id}"><g:message code="edit"/></g:link>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

    <div>
      <h1>Projekteinheiten <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-projectunits"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Projekteinheit hinzufügen" /></a></app:isMeOrAdmin></h1>
      <jq:jquery>
        <jq:toggle sourceId="show-projectunits" targetId="projectunits"/>
      </jq:jquery>
      <div id="projectunits" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectTemplateProfile', action:'addProjectUnit', id: projectTemplate.id]" update="projectunits2" before="hideform('#projectunits')">
          <g:textField name="fullName" value=""/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div id="projectunits2">
        <g:render template="projectUnits" model="[projectUnits: projectUnits, projectTemplate: projectTemplate]"/>
      </div>
    </div>

    <g:if test="${projectUnits}">
      <div>
        <h1>Aktivitätsvorlagengruppen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-groupActivityTemplates"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Aktivitätsvorlagengruppe hinzufügen" /></a></app:isMeOrAdmin></h1>
        <jq:jquery>
          <jq:toggle sourceId="show-groupActivityTemplates" targetId="groupActivityTemplates"/>
        </jq:jquery>
        <div id="groupActivityTemplates" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'projectTemplateProfile', action:'addGroupActivityTemplate', id: projectTemplate.id]" update="projectunits2" before="hideform('#groupActivityTemplates')">
            Aktivitätsvorlagengruppe: <g:select name="groupActivityTemplate" from="${allGroupActivityTemplates}" optionKey="id" optionValue="profile"/><br/>
            Hinzufügen zu: <g:select name="projectUnit" from="${projectUnits}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>
      </div>
    </g:if>

  </div>
</div>
</body>
