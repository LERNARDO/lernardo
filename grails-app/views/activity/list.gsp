<html>
  <head>
    <meta name="layout" content="private" />
    <title>Lernardo | Liste aller Aktivitäten</title>
  </head>
  <body>

  <g:if test="${entity.profile.showTips}">
      <div class="toolTip">
        <img src="${createLinkTo(dir:'images/icons',file:'icon_template.png')}" alt="toolTip"/><span class="strong">Tipp:</span> Diese Seite bietet einen Überblick über alle geplanten Aktivitäten in den Horten in denen der Pädagoge arbeitet.
      </div>
    </g:if>

    <div class="headerBlue">
      <h1>Lernardo Aktivitäten</h1>
    </div>

    <div class="boxGray">
      <div id="body-list">
        <p>${activityCount} Aktivitäten gefunden</p>

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
              <td><g:link action="show" id="${activity.id}" params="[name:entity.name]">${activity.title}</g:link></td>
              <td>${activity.facility.profile.fullName}</td>
              <td>${activity.owner.profile.fullName}</td>
              <td><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.date}"/></td>
            </tr>
          </g:each>
          </tbody>
        </table>

        <div class="paginateButtons">
          <g:paginate action="list" total="${activityCount}" />
        </div>

      </div>
    </div>
  </body>
</html>