<head>
  <meta name="layout" content="private"/>
  <title><g:message code="projectTemplates"/></title>
</head>
<body>
<div class="tabGreen">
  <div class="second">
    <h1><g:message code="projectTemplates"/></h1>
  </div>
</div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="projectProfile" action="list"><g:message code="projects"/></g:link></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="buttons">
      <g:form>
        <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'projectTemplate.create')}"/></div>
          <div class="spacer"></div>
        </erp:accessCheck>
      </g:form>
    </div>

    <div class="frame" style="border: 1px solid #aaa; padding: 5px; margin-bottom: 5px;">
      <g:formRemote name="formRemote0" url="[controller:'projectTemplateProfile', action:'updateselect']" update="templateselect" before="showspinner('#templateselect')">

        <table>
          <tr>
            <td class="bold"><g:message code="name"/>:</td>
            <td><g:textField name="name" size="30"/></td>
          </tr>
          <tr>
            <td class="bold"><g:message code="labels"/>:</td>
            <td><g:select from="${allLabels}" multiple="true" name="labels" value="" style="min-height: 115px;"/></td>
          </tr>
        </table>

        <g:submitButton name="button" value="${message(code:'define')}"/>
        <div class="spacer"></div>
      </g:formRemote>
    </div>

    <div id="templateselect">
      %{--<g:render template="searchresults" model="[allTemplates: allTemplates, currentEntity: currentEntity, paginate: paginate]"/>--}%
    </div>

    %{--<div class="info-msg">
      ${totalProjectTemplates} <g:message code="projectTemplates.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'projectTemplate.create')}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:message code="searchForName"/>: <g:remoteField size="30" name="instantSearch" update="membersearch-results" paramName="name" url="[controller:'overview', action:'searchMe', params:[projectTemplate: 'yes']]" before="showspinner('#membersearch-results')" />
    <div style="padding-bottom: 5px" class="membersearch-results" id="membersearch-results"></div>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'projectTemplate.profile.name')}"/>
        <g:sortableColumn property="status" title="${message(code:'projectTemplate.profile.status')}"/>
        <th><g:message code="projectUnitTemplates"/></th>
        <th><g:message code="creator"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${projectTemplates}" status="i" var="projectTemplate">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${projectTemplate.id}" params="[entity: projectTemplate.id]">${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><g:message code="status.${projectTemplate.profile.status}"/></td>
          <td><erp:getProjectTemplateUnitsCount template="${projectTemplate}"/></td>
          <td><erp:createdBy entity="${projectTemplate}">${creator?.profile?.fullName?.decodeHTML()}</erp:createdBy></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalProjectTemplates}"/>
    </div>--}%

  </div>
</div>
</body>
