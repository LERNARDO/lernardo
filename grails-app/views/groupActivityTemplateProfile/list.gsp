<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivityTemplates"/></title>
</head>
<body>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="groupActivityTemplates"/></h1>
  </div>
</div>
<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="groupActivityProfile" action="index"><g:message code="groupActivities"/></g:link></h1>
  </div>
</div>
<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="buttons">
      <g:form>
        <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'groupActivityTemplate.create')}"/></div>
          <div class="spacer"></div>
        </erp:accessCheck>
      </g:form>
    </div>

    <div class="frame" style="border: 1px solid #aaa; padding: 5px; margin-bottom: 5px;">
      <g:formRemote name="formRemote0" url="[controller:'groupActivityTemplateProfile', action:'updateselect2']" update="templateselect" before="showspinner('#templateselect')">

        <table>
          <tr>
            <td class="bold"><g:message code="name"/>:</td>
            <td><g:textField name="name" size="30"/></td>
          </tr>
          <tr>
            <td class="bold"><g:message code="duration"/>:</td>
            <td><g:select from="${1..239}" name="duration1" noSelection="['all':message(code:'any')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'secondselect', update:'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
              <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> (min)</td>
          </tr>
          <tr>
            <td class="bold"><g:message code="labels"/>:</td>
            <td><g:select from="${allLabels}" multiple="true" name="labels" value=""/></td>
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
      ${totalGroupActivityTemplates} <g:message code="groupActivityTemplate.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Pädagoge','Betreiber']">
      <div class="buttons">
        <g:form>
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'groupActivityTemplate.create')}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="${message(code:'groupActivityTemplate.profile.name')}"/>
        <th><g:message code="numberOfActivityTemplates"/></th>
        --}%%{--<th><g:message code="totalDuration"/></th>--}%%{--
        <g:sortableColumn property="realDuration" title="${message(code:'totalDuration')}"/>
        <th><g:message code="creator"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${groups}" status="i" var="group">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td><g:link action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
          <td><erp:getGroupSize entity="${group}"/></td>
          <td>${fieldValue(bean: group, field: 'profile.realDuration')}</td>
          <td><erp:createdBy entity="${group}">${creator?.profile?.fullName?.decodeHTML()}</erp:createdBy></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate total="${totalGroupActivityTemplates}"/>
    </div>--}%

  </div>
</div>
</body>
