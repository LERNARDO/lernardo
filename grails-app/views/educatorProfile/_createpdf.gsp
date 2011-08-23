<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title><g:message code="timeEvaluation"/></title>
    <style>
      body {
          font-size: 12px;
      }
      table {
        border-collapse: collapse;
      }
      th {
        background: #cc5;
        padding: 2px;
        border: 1px solid #aa3;
      }
      td {
        background: #eee;
        padding: 2px;
        border: 1px solid #999;
      }
      h2 {
        color: #44f;
        border-bottom: 1px solid #66f;
      }
      .bold {
        font-weight: bold;
      }
      .unit {
        border: 1px solid #ccc;
        padding: 5px;
        margin-bottom: 5px;
      }
      .gray {
        color: #aaa;
      }
    </style>
  </head>
  <body>
    <h1>Export der Zeitaufzeichnungen vom ${date1} bis ${date2}</h1>
    <p class="gray">Erstellt von ${entity.profile.fullName} am <g:formatDate date="${new Date()}" format="dd. MM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> um <g:formatDate date="${new Date()}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:message code="clock"/>.</p>
    <h2>Übersicht</h2>
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
        <th>Auszahlung (${grailsApplication.config.currency})</th>
      </tr>
      </thead>
      <tbody>
      <g:each in="${educators}" status="i" var="educator">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${fieldValue(bean: educator, field: 'profile.fullName').decodeHTML()}</td>
          <g:each in="${workdaycategories}" var="category">
            <td><erp:getHoursForCategory category="${category}" educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          </g:each>
          <td><erp:getHoursConfirmed educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          <td><erp:getTotalHours educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          <td><erp:getExpectedHours educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
          <td><erp:getSalary educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>

    %{--<table>
      <g:each in="${educators}" status="i" var="educator">
        <h2>${educator.profile.fullName}</h2>
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <erp:getWorkdayUnits educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}">
            <td>Units: ${units}</td>
            <g:each in="${units}" var="unit">
              <td><g:formatDate date="${unit.date1}" format="dd.MM.yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
              <td><g:formatDate date="${unit.date1}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> <g:formatDate date="${unit.date2}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> ${unit.category} <br/> ${unit.description.decodeHTML()}</td>
            </g:each>
          </erp:getWorkdayUnits>
        </tr>
      </g:each>
    </table>--}%

    <h2>Detaillierte Informationen</h2>
    <g:each in="${educators}" status="i" var="educator">
      <h3 style="page-break-before: always">${educator.profile.fullName}</h3>
      <erp:getWorkdayUnits educator="${educator}" date1="${date1 ?: null}" date2="${date2 ?: null}">
        <g:each in="${units}" var="unit">
          <div class="unit">
            <div style="float: left; width: 200px;">
            <span class="bold">Datum:</span> <g:formatDate date="${unit.date1}" format="dd.MM.yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/>
            <span class="bold">Von:</span> <g:formatDate date="${unit.date1}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/><br/>
            <span class="bold">Bis:</span> <g:formatDate date="${unit.date2}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
            </div>
            <div>
            <span class="bold">Kategorie:</span> ${unit.category}<br/>
            <span class="bold">Beschreibung:</span> ${unit.description.decodeHTML()}
            </div>
            <div style="clear: left;"></div>
          </div>
        </g:each>
      </erp:getWorkdayUnits>
    </g:each>

  </body>
</html>
