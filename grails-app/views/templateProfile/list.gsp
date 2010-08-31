<%@ page import="at.openfactory.ep.Entity" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="activityTemplates"/></title>
</head>

<body>

<g:if test="${currentEntity.profile.showTips}">
  <div class="toolTip">
    <div class="second">
      <img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><span class="strong"><g:message code="hint"/>:</span> <g:message code="activityTemplate.list.hint"/>
    </div>
  </div>
</g:if>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="activityTemplates"/></h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <p>${templateCount} <g:message code="activityTemplate.c_total"/></p>

    <table class="default-table">
      <thead>
      <tr>
        <g:sortableColumn property="fullName" title="Name"/>
        <g:sortableColumn property="duration" title="Dauer (min)"/>
        <g:sortableColumn property="socialForm" title="Sozialform"/>
        <th>Kommentare</th>
      </tr>
      </thead>

      <tbody>
      <g:each status="i" in="${templateList}" var="templateInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
          <td><g:link action="show" id="${templateInstance.id}" params="[entity: templateInstance.id]">${templateInstance.profile.fullName.decodeHTML()}</g:link></td>
          <td>${templateInstance.profile.duration}</td>
          <td>${templateInstance.profile.socialForm}</td>
          <td>${templateInstance.profile.comments.size()}</td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate action="list" total="${templateCount}"/>
    </div>

    <div class="buttons">
      <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false">
        <g:link class="buttonGreen" controller="templateProfile" action="create"><g:message code="activityTemplate.create"/></g:link>
        <div class="spacer" style="margin-bottom: 5px"></div>
      </app:hasRoleOrType>
    </div>

  </div>
</div>
</body>