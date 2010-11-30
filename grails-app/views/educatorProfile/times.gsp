<head>
  <meta name="layout" content="private"/>
  <title>Zeitauswertung</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Zeitauswertung</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p>Bitte einen Zeitraum auswählen um die Zeitauswertung zu erstellen:</p>

    <g:formRemote name="formRemote" url="[controller:'educatorProfile', action:'showresult']" update="results" before="showspinner('#results')">
      <g:textField name="date1" size="30" class="datepicker-birthday"/>
      <g:textField name="date2" size="30" class="datepicker-birthday"/>
      <div class="spacer"></div>
      <g:submitButton name="submitButton" value="OK"/>
      <div class="spacer"></div>
    </g:formRemote>

    <div id="results" style="margin-top: 10px">
      <table class="default-table">
        <thead>
        <tr>
          <th>Name</th>
          <g:each in="${workdaycategories}" var="category">
            <th>${category.name} (h)</th>
          </g:each>
          <th>Bestätigt</th>
          <th>Habenstunden</th>
          <th>Sollstunden</th>
          <th>Auszahlung</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${educators}" status="i" var="educator">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td><g:link action="show" id="${educator.id}" params="[entity: educator.id]">${fieldValue(bean: educator, field: 'profile.fullName').decodeHTML()}</g:link></td>
            <g:each in="${workdaycategories}" var="category">
              <td><app:getHoursForCategory category="${category}" educator="${educator}"/></td>
            </g:each>
            <td>TODO</td>
            <td><app:getTotalHours educator="${educator}"/></td>
            <td>TODO</td>
            <td>TODO</td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <br/>
      [PDF erzeugen]
    </div>

  </div>
</div>

</body>