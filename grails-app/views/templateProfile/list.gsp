<%@ page import="de.uenterprise.ep.Entity" %>
<head>
  <meta name="layout" content="private"/>
  <title>Lernardo Aktivitätsvorlagen</title>
</head>

<body>
<g:if test="${entity.profile.showTips}">
  <div class="toolTip">
    <div class="second">
      <img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><span class="strong">Tipp:</span> Diese Seite bietet einen Überblick über sämtliche im Lernardo erfassten Aktivitätsvorlagen.
    </div>
  </div>
</g:if>
<div class="tabGreen">
  <div class="second">
    <h1>Aktivitätsvorlagen %{--<app:getTemplateCount/>--}%</h1>
  </div>
</div>

<div class="clearFloat"> </div>

<div class="boxGray">
  <div class="second">
    <div id="body-list">

      <p>${templateCount} Aktivitätsvorlage(n) gefunden</p>

      <table>
        <thead>
        <tr>
          <g:sortableColumn property="name" title="Name"/>
          <g:sortableColumn property="duration" title="Dauer (min)"/>
          <g:sortableColumn property="socialForm" title="Sozialform"/>
          <th>Kommentare</th>
        </tr>
        </thead>

        <tbody>
        <g:each status="i" in="${templateList}" var="templateInstance">
          <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <td class="col"><g:link action="show" id="${templateInstance.id}" params="[entity: templateInstance.id]">${templateInstance.profile.fullName}</g:link></td>
            <td class="col2">${templateInstance.profile.duration}</td>
            <td>${templateInstance.profile.socialForm}</td>
            <td>${templateInstance.profile.comments.size()}</td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <g:if test="${templateCount > 15}">
        <div class="paginateButtons">
          <g:paginate action="list" total="${templateCount}"/>
        </div>
      </g:if>

     <div class="buttons">
        <app:isEducator entity="${entity}">
          <g:link class="buttonGreen" controller="templateProfile" action="create">Aktivitätsvorlage erstellen</g:link>
          <div class="spacer" style="margin-bottom: 5px"></div>
        </app:isEducator>
      </div>
    </div>
  </div>
</div>
</body>