<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="project"/> - ${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}</title>
</head>

<body>
<div class="boxHeader">
  <h1><erp:getFavorite entity="${project}"/> ${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()} <span style="font-size: 12px;">(<g:message code="project"/>)</span></h1>
</div>
<g:render template="/templates/favmodal" model="[entity: project]"/>

<div class="boxGray">
  <div class="second">

    <g:render template="/templates/projectNavigation" model="[entity: project]"/>

      <div style="margin-top: 10px; height: 30px;">
          <span class="zusatz-show" id="labels2">
              <g:render template="labels" model="[project: project]"/>
          </span>
          <span class="zusatz-add hidden" id="labels">
              <g:formRemote name="formRemote2" url="[controller: 'projectProfile', action: 'addLabel', id: project.id]" update="labels2" before="showspinner('#labels2');" after="jQuery('#labels').toggleClass('hidden').toggleClass('visible');">
                  <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
                  <g:submitButton name="button" value="${message(code:'add')}"/>
              </g:formRemote>
          </span>
          <div class="clear"></div>
      </div>

    <div class="tabnav">
      <ul>
        <li><g:link controller="projectProfile" action="show" id="${project.id}"><g:message code="profile"/></g:link></li>
          <li><g:remoteLink update="content" controller="projectProfile" action="management" id="${project.id}"><g:message code="management"/></g:remoteLink></li>
          <li><g:remoteLink update="content" controller="projectProfile" action="projectdays" id="${project.id}"><g:message code="projectDays"/></g:remoteLink></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${project.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${project}"/></g:remoteLink></li>
        <erp:accessCheck types="['Pädagoge','Betreiber']">
          <li><g:remoteLink update="content" controller="comment" action="show" id="${project.id}"><g:message code="comments"/> (${project.profile.comments.size()})</g:remoteLink></li>
          <li><g:link style="border-right: none" controller="projectProfile" action="listevaluations" id="${project.id}" params="[entity:project.id]"><g:message code="privat.evaluation"/></g:link></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">
        <h4><g:message code="profile"/></h4>

      <g:if test="${template}">
        <p><g:message code="projectTemplate"/>: <g:link class="largetooltip" data-idd="${template.id}" controller="projectTemplateProfile" action="show" id="${template?.id}">${template?.profile?.fullName}</g:link></p>
      </g:if>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: project]"/></span> <erp:accessCheck roles="['ROLE_ADMIN']"><img onclick="toggle('#setcreator');" src="${g.resource(dir: 'images/icons', file: 'bullet_arrow_toggle.png')}" alt="Ersteller ändern"/></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${project.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

            <tr class="prop">
              <td class="one"><g:message code="name"/></td>
              <td class="two">${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}</td>
            </tr>

            <tr class="prop">
              <td class="one"><g:message code="begin"/></td>
              <td class="two"><g:formatDate date="${project.profile.startDate}" format="dd. MM. yyyy" /></td>
            </tr>

            <tr class="prop">
              <td class="one"><g:message code="end"/></td>
              <td class="two"><g:formatDate date="${project.profile.endDate}" format="dd. MM. yyyy" /></td>
            </tr>

            <tr class="prop">
              <td class="one"><g:message code="description"/></td>
              <td class="two">${fieldValue(bean: project, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
            </tr>

            <tr class="prop">
              <td class="one"><g:message code="project.profile.educationalObjective"/></td>
              <td class="two">
                <g:if test="${project.profile.educationalObjective}">
                  <g:message code="goal.${project.profile.educationalObjective}"/>
                </g:if>
                <g:else>
                  <span class="italic"><g:message code="none"/></span>
                </g:else>
              </td>
            </tr>

            <tr class="prop">
              <td class="one"><g:message code="project.profile.educationalObjectiveText"/></td>
              <td class="two">${fieldValue(bean: project, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
            </tr>

            <g:if test="${project.profile.completed}">
                <tr class="prop">
                    <td class="one"><g:message code="project.objectiveReached"/></td>
                    <td class="two"><g:formatBoolean boolean="${project.profile.objectiveReached}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
                </tr>

                <tr class="prop">
                    <td class="one"><g:message code="project.objectiveComment"/></td>
                    <td class="two">${fieldValue(bean: project, field: 'profile.objectiveComment').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
                </tr>

                <tr class="prop">
                    <td class="one"><g:message code="project.goodFactors"/></td>
                    <td class="two">${fieldValue(bean: project, field: 'profile.goodFactors').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
                </tr>

                <tr class="prop">
                    <td class="one"><g:message code="project.badFactors"/></td>
                    <td class="two">${fieldValue(bean: project, field: 'profile.badFactors').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
                </tr>

                <tr class="prop">
                    <td class="one"><g:message code="project.wouldRepeatIt"/></td>
                    <td class="two"><g:formatBoolean boolean="${project.profile.wouldRepeatIt}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
                </tr>

                <tr class="prop">
                    <td class="one"><g:message code="project.repeatReason"/></td>
                    <td class="two">${fieldValue(bean: project, field: 'profile.repeatReason').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+ '</span>'}</td>
                </tr>
            </g:if>


        </tbody>
      </table>

        <g:if test="${!project.profile.completed}">
            <p class="italic"><g:message code="project.notCompleted"/></p>
        </g:if>

    </div>

  </div>
</div>

</body>

