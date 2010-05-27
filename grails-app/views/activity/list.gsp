<html>
  <head>
    <meta name="layout" content="private" />
    <title>Themenraumaktivitäten</title>
  </head>
  <body>

  <g:if test="${entity.profile.showTips}">
      <div class="toolTip">
        <div class="second">
          <img src="${resource(dir:'images/icons',file:'icon_template.png')}" alt="toolTip" align="top"/><span class="strong">Tipp:</span> Diese Seite bietet einen Überblick über alle geplanten Aktivitäten in deinen Einrichtungen.
        </div>
      </div>
    </g:if>

    <div class="headerBlue">
      <div class="second">
        <h1>Themenraumaktivitäten</h1>
      </div>
    </div>

    <div class="boxGray">
      <div class="second">
        <div id="body-list">
          <p>${activityCount} Themenraumaktivität(en)
            <g:if test="${dateSelected}">am <g:formatDate date="${dateSelected}" format="dd. MM. yyyy"/></g:if>
            <g:else>insgesamt</g:else>
            gefunden.
          </p>

          <div id="select-box">
            Filtern nach:
            <g:form name="form1" action="list">
              <g:datePicker name="myDate" value="${dateSelected}" precision="day" years="${2009..2010}" />
              <div class="buttons">
                <g:submitButton name="list" value="OK" />
                <g:submitButton name="list" value="Alle" />
                <div class="spacer"></div>
              </div>
            </g:form>
          </div>

          <table>
            <thead>
              <tr>
                <g:sortableColumn property="title" title="Aktivit&auml;t" />
                <g:sortableColumn property="facility" title="Einrichtung" />
                <g:sortableColumn property="date" title="Datum" />
                <th>Kommentare</th>
              </tr>
            </thead>
            <tbody>
            <g:each status="i" in="${activityList}" var="activity">
              <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
                <td><g:link action="show" id="${activity.id}" params="[name:entity.name]">${activity.profile.fullName}</g:link></td>
                <td><app:getFacility entity="${activity}">${facility.profile.fullName}</app:getFacility></td>
                %{--<td><app:getCreator entity="${activity}">${creator.profile.fullName}</app:getCreator></td>--}%
                <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}"/></td>
                <td>${activity.profile.comments.size()}</td>
              </tr>
            </g:each>
            </tbody>
          </table>

          <g:if test="${activityCount > 10}">
            <div class="paginateButtons">
              <g:paginate action="list" total="${activityCount}" />
            </div>
          </g:if>

        </div>
      </div>
    </div>
  </body>
</html>