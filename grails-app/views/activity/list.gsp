<html>
<head>
  <meta name="layout" content="private"/>
  <title>Themenräume</title>
</head>
<body>

<g:if test="${currentEntity.profile.showTips}">
  <div class="toolTip">
    <div class="second">
      <img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><span class="strong"><g:message code="hint"/></span> Diese Seite bietet einen Überblick über alle geplanten Aktivitäten in deinen Einrichtungen.
    </div>
  </div>
</g:if>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="activity" action="create">Themenraum anlegen</g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1>Themenräume</h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="clear"></div>

    <p>${activityCount} Themenräume
    <g:if test="${dateSelected}">am <g:formatDate date="${dateSelected}" format="dd. MM. yyyy"/></g:if>
    <g:else>insgesamt</g:else>
    gefunden.
    </p>

    <div id="select-box">
      Filtern nach:
      <g:form name="form1" action="list">
        <g:datePicker name="myDate" value="${dateSelected}" precision="day" years="${2009..2010}"/>
        <div class="buttons">
          <g:submitButton name="list" value="OK"/>
          <g:submitButton name="list" value="Alle"/>
          <div class="spacer"></div>
        </div>
      </g:form>
    </div>

    <table class="default-table">
      <thead>
      <tr>
        <th>Aktivität</th>
        <th>Einrichtung</th>
        <th>Datum</th>
        %{--<th>Typ</th>--}%
        <th>Kommentare</th>
      </tr>
      </thead>
      <tbody>
      <g:each status="i" in="${activityList}" var="activity">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
          <td><g:link action="show" id="${activity.id}" params="[name:currentEntity.name]">${activity.profile.fullName}</g:link></td>
          <td><app:getFacility entity="${activity}">${facility.profile.fullName}</app:getFacility></td>
          <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}"/></td>
          %{--<td>${activity.profile.type}</td>--}%
          <td>${activity.profile.comments.size()}</td>
        </tr>
      </g:each>
      </tbody>
    </table>

    <div class="paginateButtons">
      <g:paginate action="list" total="${activityCount}"/>
    </div>

  </div>
</div>
</body>
</html>