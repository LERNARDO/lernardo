<html>
<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="themeRooms"/></title>
</head>
<body>

%{--<g:if test="${currentEntity.profile.showTips}">
  <div class="toolTip" id="tooltip">
    <div class="second">
      <img src="${resource(dir: 'images/icons', file: 'icon_template.png')}" alt="toolTip" align="top"/><span class="strong"><g:message code="hint"/></span> <g:message code="tooltip.activities"/>
      <span style="float: right"><a onclick="toggle('#tooltip'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'cross.png')}" alt="Close"/></a></span>
    </div>
  </div>
</g:if>--}%

%{--<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="activityProfile" action="create"><g:message code="themeRoom.create"/></g:link></h1>
  </div>
</div>--}%

<div class="boxGreen">
  <div class="second">
    <h1><g:message code="themeRooms"/></h1>
  </div>
</div>

%{--<div class="clearFloat"></div>--}%

<div class="boxGray">
  <div class="second">

    %{--<div class="clear"></div>--}%

    <div class="info-msg">
      ${activityCount} <g:message code="themeRooms"/>
      <g:if test="${dateSelected}">am <g:formatDate date="${dateSelected}" format="dd. MM. yyyy"/></g:if>
      <g:message code="found"/>
    </div>

    <div class="buttons">
      <g:link class="buttonGreen" controller="activityProfile" action="create"><g:message code="themeRoom.create"/></g:link>
      <div class="clear"></div>
    </div>

    <div id="select-box">
      <g:message code="filterBy"/>:
      <g:form>
        <g:textField class="datepicker" name="myDate" value="${formatDate(date: dateSelected, format: 'dd. MM. yyyy' )}"/>
        <div class="buttons">
          <div class="button"><g:actionSubmit class="buttonGreen" action="list" value="OK"/></div>
          <div class="button"><g:link class="buttonGreen" action="list" params="[myDate: 'all']"><g:message code="all"/></g:link></div>
          <div class="clear"></div>
        </div>
      </g:form>
    </div>

    <table class="default-table">
      <thead>
      <tr>
        <th><g:message code="activity"/></th>
        <th><g:message code="facility"/></th>
        <th><g:message code="date"/></th>
        <th><g:message code="comments"/></th>
      </tr>
      </thead>
      <tbody>
      <g:each status="i" in="${activityList}" var="activity">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
          <td><g:link action="show" id="${activity.id}">${activity.profile.fullName.decodeHTML()}</g:link></td>
          <td><erp:getFacility entity="${activity}">${facility.profile.fullName.decodeHTML()}</erp:getFacility></td>
          <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
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