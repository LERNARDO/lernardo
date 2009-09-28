<html>
  <head>
    <meta name="layout" content="private" />
    <title>Liste aller Aktivitäten</title>
  </head>
  <body>
    <div id="body-list">
      <h2>Liste aller Aktivitäten</h2>
      <p>${activityCount} Aktivitäten gefunden</p>

      <div id="select-box">
      Filtern nach:
        
        <g:form name="form1" action="list">
          <label>Monat
            <select name="perMonth">
              <option value="alle">Alle</option>
              <option value="01">Jänner</option>
              <option value="02">Februar</option>
              <option value="03">März</option>
              <option value="04">April</option>
              <option value="05">Mai</option>
              <option value="06">Juni</option>
              <option value="07">Juli</option>
              <option value="08">August</option>
              <option value="09">September</option>
              <option value="10">Oktober</option>
              <option value="11">November</option>
              <option value="12">Dezember</option>
            </select>
          </label>
          <g:submitButton name="list" value="OK" />
        </g:form>

        %{-- Preparation for sorting by day

        <g:form name="form2" action="list">
          <label>Tag
            <select name="perMonth">
              <g:each in="dayCount">
                <option value="Date(v.value.date).format("dd")">Date(v.value.date).format("dd")</option>
              </g:each>
            </select>
          </label>
          <g:submitButton name="list" value="OK" />
        </g:form>

        --}%

      </div>

      <table>
        <thead>
          <tr>
        <g:sortableColumn property="title" title="Aktivitätsvorlage" />
        <g:sortableColumn property="date" title="Datum" />
        <g:sortableColumn property="startTime" title="Startzeit" />
        <g:sortableColumn property="duration" title="Dauer" />
        <g:sortableColumn property="paedList" title="Team" />
        <g:sortableColumn property="clientList" title="Teilnehmer" />
        </tr>
        </thead>
        <tbody>
        <g:each status="i" in="${activityList}" var="activityInstance">
          <tr class="${ (i % 2) == 0 ? 'even' : 'odd'}">
            <td><g:link action="show" id="${activityInstance.value.id}">${activityInstance.value.title}</g:link></td>
            <td>${activityInstance.value.date}</td>
            <td>${activityInstance.value.startTime}</td>
            <td>${activityInstance.value.duration}</td>
            <td>
          <g:each in="${activityInstance.value.paedList}" var="paedListInstance">
${paedListInstance[0].toUpperCase()+paedListInstance.substring(1)}<br>
          </g:each>
        </td>
          <td>
          <g:each in="${activityInstance.value.clientList}" var="clientListInstance">
${clientListInstance[0].toUpperCase()+clientListInstance.substring(1)}<br>
          </g:each>
          </td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:set var="pMonth" value="${activityType}" />
        <g:paginate action="list"
                    params="[perMonth:pMonth]"
                    total="${activityCount}" />
      </div>

    </div>
  </body>
</html>