<html>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="themeRooms"/></title>
</head>
<body>

<g:if test="${currentEntity.profile.showTips}">
  <div class="toolTip" id="tooltip">
    <div class="second">
      <img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><span class="strong"><g:message code="hint"/></span> Diese Seite bietet einen Überblick über alle geplanten Aktivitäten in deinen Einrichtungen.
      <span style="float: right"><a onclick="toggle('#tooltip'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'cross.png')}" alt="Close"/></a></span>
    </div>
  </div>
</g:if>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="activityProfile" action="create"><g:message code="themeRoom.create"/></g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1><g:message code="themeRooms"/></h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="clear"></div>

    <div class="info-msg">
      ${activityCount} Themenräume
      <g:if test="${dateSelected}">am <g:formatDate date="${dateSelected}" format="dd. MM. yyyy"/></g:if>
      <g:else>insgesamt</g:else>
      gefunden.
    </div>

    <div id="select-box">
      <g:message code="filterBy"/>:
      <g:form name="form1" action="list">
        <g:datePicker name="myDate" value="${dateSelected}" precision="day" years="${2009..2011}"/>
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
        <th><g:message code="activity"/></th>
        <th><g:message code="facility"/></th>
        <th><g:message code="date"/></th>
        %{--<th>Typ</th>--}%
        <th><g:message code="comments"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each status="i" in="${activityList}" var="activity">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
          <td><g:link action="show" id="${activity.id}" params="[name:currentEntity.name]">${activity.profile.fullName}</g:link></td>
          <td><erp:getFacility entity="${activity}">${facility.profile.fullName}</erp:getFacility></td>
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