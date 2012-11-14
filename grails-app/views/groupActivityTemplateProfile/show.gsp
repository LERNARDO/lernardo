<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="groupActivityTemplate"/> - ${fieldValue(bean: group, field: 'profile').decodeHTML()}</title>
</head>
<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${group}"/> ${fieldValue(bean: group, field: 'profile').decodeHTML()} <span style="font-size: 12px;">(<g:message code="groupActivityTemplate"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: group]"/>

<div class="boxContent">

    <g:render template="/templates/groupActivityTemplateNavigation" model="[entity: group]"/>

      <div style="margin-top: 10px; height: 30px;">
          <span class="zusatz-show" id="labels2">
              <g:render template="labels" model="[group: group]"/>
          </span>
          <span class="zusatz-add hidden" id="labels">
              <g:formRemote name="formRemote2" url="[controller: 'groupActivityTemplateProfile', action: 'addLabel', id: group.id]" update="labels2" before="showspinner('#labels2');" after="jQuery('#labels').toggleClass('hidden').toggleClass('visible');">
                  <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
                  <g:submitButton name="button" value="${message(code:'add')}"/>
              </g:formRemote>
          </span>
          <div class="clear"></div>
      </div>

    <div class="tabnav">
      <ul>
        <li><g:link controller="groupActivityTemplateProfile" action="show" id="${group.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="groupActivityTemplateProfile" action="management" id="${group.id}" before="showspinner('#content');"><g:message code="management"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${group.id}" before="showspinner('#content');"><g:message code="publications"/> <erp:getPublicationCount entity="${group}"/></g:remoteLink></li>
        <erp:accessCheck types="['Betreiber','Pädagoge']">
          <li><g:remoteLink update="content" controller="comment" action="show" id="${group.id}" before="showspinner('#content');"><g:message code="comments"/> (${group.profile.comments.size()}) </g:remoteLink></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: group]"/></span> <erp:accessCheck roles="['ROLE_ADMIN']"><img onclick="toggle('#setcreator');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="Ersteller ändern"/></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${group.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/></td>
          <td class="two">${fieldValue(bean: group, field: 'profile').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupActivityTemplate.profile.realDuration"/></td>
          <td class="two">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="status"/></td>
          <td class="two"><g:message code="status.${group.profile.status}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/></td>
          <td class="two">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupActivityTemplate.profile.educationalObjectiveText"/></td>
          <td class="two">${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
          <td class="two">${group?.profile?.ageFrom ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageTo"/></td>
          <td class="two">${group?.profile?.ageTo ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
        </tr>

        </tbody>
      </table>

      <g:if test="${group.profile.status != 'done'}">
        <div class="italic red"><g:message code="template.statusNotDone"/></div>
      </g:if>

    </div>

</div>
</body>
