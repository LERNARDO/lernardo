<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Liste aller Aktivitäten</title>
  </head>
  <body>

  <g:if test="${entity.profile.showTips}">
      <div class="toolTip">
        <img src="${createLinkTo(dir:'images/icons',file:'icon_template.png')}" alt="toolTip" align="top"/><span class="strong">Tipp:</span> Diese Seite bietet einen Überblick über alle geplanten Aktivitäten in deinen Einrichtungen.
      </div>
    </g:if>

    <div class="headerBlue">
      <h1>Lernardo Aktivitäten</h1>
    </div>

    <div class="boxGray">
      <div id="body-list">
        <p>${activityCount} Aktivität(en)
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
            </div>
          </g:form>
        </div>

        <table>
          <thead>
            <tr>
              <g:sortableColumn property="title" title="Aktivit&auml;t" />
              <g:sortableColumn property="facility" title="Einrichtung" />
              <g:sortableColumn property="owner" title="Geplant von" />
              <g:sortableColumn property="date" title="Datum" />
            </tr>
          </thead>
          <tbody>
          <g:each status="i" in="${activityList}" var="activity">
            <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
              <td><g:link action="show" id="${activity.id}" params="[name:entity.name]">${activity.profile.fullName}</g:link></td>
              <td><app:getFacility entity="${activity}">${facility.profile.fullName}</app:getFacility></td>
              <td><app:getCreator entity="${activity}">${creator.profile.fullName}</app:getCreator></td>
              <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}"/></td>
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
  </body>
</html>