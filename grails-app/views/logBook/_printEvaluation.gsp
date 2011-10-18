<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Logbuch</title>
    <style>
      @page {
        size: 297mm 210mm;
      }
      body {
          font-size: 12px;
      }
      .default-table th {
        border-bottom: 1px solid #000;
      }
      h2 {
        color: #44f;
        border-bottom: 1px solid #66f;
      }
      .gray {
        color: #aaa;
      }
      .one {
        font-weight: bold;
      }
    </style>
  </head>
  <body>

  <h1>Logbuch von "${facility.profile.fullName}" vom Monat ${formatDate(date: logMonth.date, format: 'MMMM yyyy')}</h1>
  <p class="gray"><g:message code="createdBy" args="[currentEntity.profile.fullName, formatDate(date: new Date(), format: 'dd. MM. yyyy', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())), formatDate(date: new Date(), format: 'HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))]"/></p>

  <h2>Übersicht</h2>
  <erp:renderLogMonthPrint logMonth="${logMonth}" facility="${facility}" date="${date}"/>

  <h2>Details</h2>
  <erp:renderLogMonthEntries facility="${facility}" date="${date}"/>

  </body>
</html>