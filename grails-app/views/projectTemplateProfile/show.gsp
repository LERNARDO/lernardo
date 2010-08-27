<head>
  <meta name="layout" content="private"/>
  <title>Projektvorlage</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Projektvorlage</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="projectTemplate.profile.name"/></td>
          <td valign="top" class="name-show"><g:message code="projectTemplate.profile.status"/></td>
        </tr>

        <tr>
          <td width="650px" valign="top" class="value-show">
            <g:link controller="projectTemplateProfile" action="show" id="${projectTemplate.id}" params="[entity: projectTemplate.id]">${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
          <td width="120px" valign="top" class="value-show">
            ${fieldValue(bean: projectTemplate, field: 'profile.status')}
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name-show"><g:message code="projectTemplate.profile.description"/></td>
        </tr>

        <tr>
          <td colspan="2" valign="top" class="value-show-block">
            ${fieldValue(bean: projectTemplate, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
          </td>
        </tr>
        </tbody>
      </table>

    </div>
    <div class="buttons">
      <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false">
        <g:link class="buttonGreen" action="edit" id="${projectTemplate?.id}"><g:message code="edit"/></g:link>
        <g:if test="${projectTemplate.profile.status == 'fertig'}">
          <g:link class="buttonGreen" controller="projectProfile" action="create" id="${projectTemplate?.id}">Projekt planen</g:link>
        </g:if>
      </app:hasRoleOrType>
      <g:link class="buttonGreen" action="create" id="${projectTemplate.id}">Vorlage duplizieren</g:link>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5>Projekteinheiten <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false"><g:remoteLink action="addProjectUnit" update="projectunits2" id="${projectTemplate.id}" before="showspinner('#projectunits2')"><img src="${g.resource(dir: 'images/icons', file: 'icon_add-plus.png')}" alt="Projekteinheit hinzufügen"/></g:remoteLink>
      %{--<a onclick="toggle('#projectunits'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Projekteinheit hinzufügen" /></a>--}%</app:hasRoleOrType></h5>
      %{--<div class="zusatz-add" id="projectunits" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectTemplateProfile', action:'addProjectUnit', id: projectTemplate.id]" update="projectunits2" before="showspinner('#projectunits2')">
          Name: <g:textField name="fullName" size="40" value=""/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>--}%
      <div class="zusatz-show" id="projectunits2">
        <g:render template="projectUnits" model="[projectUnits: projectUnits, projectTemplate: projectTemplate, allGroupActivityTemplates: allGroupActivityTemplates, entity: currentEntity]"/>
      </div>
    </div>

    %{--<g:if test="${projectUnits}">
      <div>
        <h5>Aktivitätsvorlagengruppen <app:isMeOrAdmin entity="${entity}"><a onclick="toggle('#groupActivityTemplates'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Aktivitätsvorlagengruppe hinzufügen" /></a></app:isMeOrAdmin></h5>
        <div id="groupActivityTemplates" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'projectTemplateProfile', action:'addGroupActivityTemplate', id: projectTemplate.id]" update="projectunits2" before="showspinner('#groupActivityTemplates')">
            Aktivitätsvorlagengruppe: <g:select name="groupActivityTemplate" from="${allGroupActivityTemplates}" optionKey="id" optionValue="profile"/><br/>
            Hinzufügen zu: <g:select name="projectUnit" from="${projectUnits}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>
      </div>
    </g:if>--}%

  </div>
</div>

<g:render template="/comment/box" model="[entity: entity, commented: projectTemplate]"/>

</body>
