<head>
  <title>Aktivitätsvorlage</title>
  <meta name="layout" content="private"/>
</head>

<body>
<div class="headerGreen">
  <div class="second">
    <h1>Aktivitätsvorlage</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
   <table>
      <tr class="prop">
          <td colspan="3" valign="top" class="name-show">
          Typ:
     </td>
     </tr>
         <tr class="prop">
          <td colspan="3" valign="top" class="value-show">
           ${template.profile.type}
     </td>
     </tr>
        <tr class="prop">
          <td colspan="2" valign="top" class="name-show">
              <g:message code="activityTemplate.name"/>:
          </td>
           <td valign="top" class="name-show">
              <g:message code="activityTemplate.duration"/>:
          </td>
          </tr>

        <tr>
          <td colspan="2" valign="top" class="value-show">
            <g:link controller="templateProfile" action="show" id="${template.id}" params="[entity: template.id]">${template.profile.fullName}</g:link></td>
          <td valign="top" class="value-show">
            ${template.profile.duration} Minuten </td>
        </tr>

       <tr class="prop">
          <td width="210px" valign="top" class="name-show">
              <g:message code="activityTemplate.socialForm"/>:
          </td>
           <td width="190px" valign="top" class="name-show">
              <g:message code="activityTemplate.status"/>:
          </td>
         <td valign="top" class="name-show">
              <g:message code="activityTemplate.amountEducators"/>:
          </td>

          </tr>
        <tr>
           <td valign="top" class="value-show  ${hasErrors(bean: template, field: 'profile.socialForm', 'errors')}">
            ${template.profile.socialForm}
           </td>
           <td valign="top" class="value-show  ${hasErrors(bean: template, field: 'profile.status', 'errors')}">
            ${template.profile.status}
           </td>
          <td valign="top" class="value-show  ${hasErrors(bean: template, field: 'profile.amountEducators', 'errors')}">
            ${template.profile.amountEducators}
          </td>

        </tr>
       <tr class="prop">
          <td colspan="2" valign="top" class="name-show">
              <g:message code="activityTemplate.description"/>:
          </td>
         <td valign="top" class="name-show">
              <g:message code="activityTemplate.chosenMaterials"/>:
          </td>
         </tr>
        <tr>
          <td  colspan="2" valign="top" class="value-show-block"> ${template.profile.description.decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
          </td>
          <td width="390" valign="top" class="value-show-block"> ${template.profile.chosenMaterials.decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
          </td>
        </tr>

      </table>



    <app:isEducator entity="${entity}">
      <g:link class="buttonGreen" action="edit" id="${template.id}"><g:message code="edit"/></g:link>
      %{--<g:if test="${template.profile.status == 'fertig'}">
        <g:link class="buttonGreen" controller="activity" action="create" id="${template.id}">Themenraumaktivitäten planen</g:link>
      </g:if>--}%
      <g:link class="buttonGreen" action="create" id="${template.id}">Vorlage duplizieren</g:link>
      <g:link class="buttonGray" action="list">Zurück</g:link>
      <div class="spacer"></div>
    </app:isEducator>

    <div class="zusatz">
      <h5>Planbare Ressourcen <app:isEducator entity="${entity}"><a onclick="toggle('#resources'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Ressourcen hinzufügen" /></a></app:isEducator></h5>
      <div class="zusatz-add" id="resources" style="display:none">
            
        <g:formRemote name="formRemote" url="[controller:'templateProfile', action:'addResource', id: template.id]" update="resources2" before="showspinner('#resources2')">
          <table>
            <tr>
              <td><g:message code="resource.profile.name"/>: </td>
              <td><g:textField size="30" name="fullName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.description"/>: </td>
              <td><g:textArea rows="5" cols="50" name="description" value=""/></td>
            </tr>
          </table>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>

      </div>
      <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[resources: resources, entity: entity, template: template]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Bewertungssmethoden <app:isEducator entity="${entity}"><a onclick="toggle('#methods'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Gewichtungsmethode hinzufügen" /></a></app:isEducator></h5>
      <div class="zusatz-add" id="methods" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'templateProfile', action:'addMethod', id:template.id]" update="methods2" before="showspinner('#methods2')">
          <g:select name="method" from="${allMethods}" optionKey="id" optionValue="name"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="methods2">
        <g:render template="methods" model="[entity: entity, template: template]"/>
      </div>
    </div>

  </div>
</div>

<g:render template="/comment/box" model="[entity: entity, commented: template]"/>

</body>