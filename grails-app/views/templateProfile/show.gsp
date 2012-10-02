<head>
  <title><g:message code="activityTemplate"/> - ${fieldValue(bean: template, field: 'profile.fullName').decodeHTML()}</title>
  <meta name="layout" content="planning"/>
</head>

<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${template}"/> ${fieldValue(bean: template, field: 'profile.fullName').decodeHTML()} <span style="font-size: 12px;">(<g:message code="activityTemplate"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: template]"/>

<div class="boxContent">

    <g:render template="/templates/templateNavigation" model="[entity: template]"/>

      <div style="margin-top: 10px; height: 30px;">
      <span class="zusatz-show" id="labels2">
          <g:render template="labels" model="[template: template]"/>
      </span>
      <span class="zusatz-add hidden" id="labels">
          <g:formRemote name="formRemote2" url="[controller: 'templateProfile', action: 'addLabel', id: template.id]" update="labels2" before="showspinner('#labels2');" after="jQuery('#labels').toggleClass('hidden').toggleClass('visible');">
              <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
              <g:submitButton name="button" value="${message(code:'add')}"/>
          </g:formRemote>
      </span>
      <div class="clear"></div>
  </div>

    <div class="tabnav">
      <ul>
        <li><g:link controller="templateProfile" action="show" id="${template.id}"><g:message code="profile"/></g:link></li>
          <li><g:remoteLink update="content" controller="templateProfile" action="management" id="${template.id}"><g:message code="management"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${template.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${template}"/></g:remoteLink></li>
        <erp:accessCheck types="['Betreiber','Pädagoge']">
          <li><g:remoteLink style="border-right: none" update="content" controller="comment" action="show" id="${template.id}"><g:message code="comments"/> (${template.profile.comments.size()}) </g:remoteLink></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: template]"/></span> <erp:accessCheck roles="['ROLE_ADMIN']"><img onclick="toggle('#setcreator');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="Ersteller ändern"/></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${template.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/></td>
          <td class="two">${template.profile.fullName.decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="duration"/></td>
          <td class="two">${template.profile.duration} <g:message code="minutes"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.socialForm"/></td>
          <td class="two"><g:message code="socialForm.${template.profile.socialForm}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="status"/></td>
          <td class="two"><g:message code="status.${template.profile.status}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.amountEducators"/></td>
          <td class="two">${template.profile.amountEducators}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/></td>
          <td class="two">${template.profile.description.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.chosenMaterials"/></td>
          <td class="two">${template.profile.chosenMaterials.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
          <td class="two">${template?.profile?.ageFrom ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageTo"/></td>
          <td class="two">${template?.profile?.ageTo ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.goal"/></td>
          <td class="two">${template?.profile?.goal?.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        </tbody>
      </table>

    </div>

</div>

</body>