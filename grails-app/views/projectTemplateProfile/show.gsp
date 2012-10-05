<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="projectTemplate"/> - ${fieldValue(bean: projectTemplate, field: 'profile').decodeHTML()}</title>
</head>
<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${projectTemplate}"/> ${fieldValue(bean: projectTemplate, field: 'profile').decodeHTML()} <span style="font-size: 12px;">(<g:message code="projectTemplate"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: projectTemplate]"/>

<div class="boxContent">

    <g:render template="/templates/projectTemplateNavigation" model="[entity: projectTemplate]"/>

      <div style="margin-top: 10px; height: 30px;">
          <span class="zusatz-show" id="labels2">
              <g:render template="labels" model="[projectTemplate: projectTemplate]"/>
          </span>
          <span class="zusatz-add hidden" id="labels">
              <g:formRemote name="formRemote2" url="[controller: 'projectTemplateProfile', action: 'addLabel', id: projectTemplate.id]" update="labels2" before="showspinner('#labels2');" after="jQuery('#labels').toggleClass('hidden').toggleClass('visible');">
                  <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
                  <g:submitButton name="button" value="${message(code:'add')}"/>
              </g:formRemote>
          </span>
          <div class="clear"></div>
      </div>

    <div class="tabnav">
      <ul>
        <li><g:link controller="projectTemplateProfile" action="show" id="${projectTemplate.id}"><g:message code="profile"/></g:link></li>
          <li><g:remoteLink update="content" controller="projectTemplateProfile" action="management" id="${projectTemplate.id}"><g:message code="management"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${projectTemplate.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${projectTemplate}"/></g:remoteLink></li>
        <erp:accessCheck types="['Betreiber','Pädagoge']">
          <li><g:remoteLink style="border-right: none" update="content" controller="comment" action="show" id="${projectTemplate.id}"><g:message code="comments"/> (${projectTemplate.profile.comments.size()}) </g:remoteLink></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: projectTemplate]"/></span> <erp:accessCheck roles="['ROLE_ADMIN']"><img onclick="toggle('#setcreator');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="Ersteller ändern"/></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${projectTemplate.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: projectTemplate, field: 'profile').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="status"/>:</td>
          <td class="two"><g:message code="status.${projectTemplate.profile.status}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: projectTemplate, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="projectTemplate.profile.educationalObjectiveText"/>:</td>
          <td class="two">${fieldValue(bean: projectTemplate, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
          <td class="two">${projectTemplate?.profile?.ageFrom ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageTo"/></td>
          <td class="two">${projectTemplate?.profile?.ageTo ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        </tbody>
      </table>

      <g:if test="${projectTemplate.profile.status != 'done'}">
        <div class="italic red"><g:message code="template.statusNotDone"/></div>
      </g:if>

    </div>

</div>

</body>
